//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

public struct GameReducer: ReducerProtocol {

    public init() {}

    public func reduce(state: GameState, action: GameAction) -> GameState {
        guard state.isOver == nil else {
            return state
        }

        var state = state
        state.event = nil
        state.error = nil

        do {
            state = try prepareAction(action: action, state: state)
            state = try executeAction(action: action, state: state)
            state = postExecuteAction(action: action, state: state)
            state = updateGameOver(state: state)
        } catch {
            state.error = error as? GameError
        }

        return state
    }
}

private extension GameReducer {

    func prepareAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state

        if let chooseOne = state.chooseOne {
            guard chooseOne.options.values.contains(action) else {
                throw GameError.unwaitedAction
            }
            state.chooseOne = nil
        }

        if state.queue.first == action {
            state.queue.removeFirst()
        }

        return state
    }

    func executeAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        state = try action.reduce(state: state)
        switch action {
        case .play,
                .resolve,
                .groupActions:
            break

        default:
            state.event = action
        }
        return state
    }

    func postExecuteAction(action: GameAction, state: GameState) -> State {
        var state = state

        var players = state.playOrder
        if case let .eliminate(justEliminated) = state.event {
            players.append(justEliminated)
        }

        for actor in players {
            let actorObj = state.player(actor)
            for card in (actorObj.abilities.union(state.abilities)) {
                let ctx = EffectContext(actor: actor, card: card)
                if let effect = triggeredEffect(ctx: ctx, state: state) {
                    let sideEffect = effect.withCtx(EffectContext(actor: actor, card: card))
                    state.queue.insert(sideEffect, at: 0)
                }
            }
        }
        return state
    }
    
    func triggeredEffect(ctx: EffectContext, state: GameState) -> CardEffect? {
        guard let cardObj = state.cardRef[ctx.card] else {
            return nil
        }
        
        for cardAction in cardObj.actions {
            do {
                let eventMatched = try cardAction.eventReq.match(state: state, ctx: ctx)
                if eventMatched {
                    let gameAction = GameAction.resolve(cardAction.effect, ctx: ctx)
                    try gameAction.validate(state: state)

                    return cardAction.effect
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    func updateGameOver(state: GameState) -> GameState {
        if let winner = state.getWinner() {
            var state = state
            state.isOver = GameOver(winner: winner)
            return state
        }

        return state
    }
}

protocol GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState
}

extension GameAction {
    func reduce(state: GameState) throws -> GameState {
        var state = state
        state = try reducer().reduce(state: state)
        return state
    }
}

private extension GameAction {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol {
        switch self {
        case let .play(actor, card, target): return Play(actor: actor, card: card, target: target)
        case let .heal(player, value): return Heal(player: player, value: value)
        case let .damage(player, value): return Damage(player: player, value: value)
        case let .discard(player, card): return Discard(player: player, card: card)
        case let .draw(player): return Draw(player: player)
        case let .steal(player, target, card): return Steal(player: player, target: target, card: card)
        case .reveal: return Reveal()
        case let .chooseCard(player, card): return ChooseCard(player: player, card: card)
        case let .groupActions(actions): return GroupActions(children: actions)
        case let .setTurn(player): return SetTurn(player: player)
        case let .eliminate(player): return Eliminate(player: player)
        case let .resolve(effect, ctx): return Resolve(effect: effect, ctx: ctx)
        case let .chooseOne(chooser, options): return ChooseOneReducer(chooser: chooser, options: options)
        }
    }
}
