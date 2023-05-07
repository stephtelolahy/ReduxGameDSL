//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

protocol GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState
}

protocol EventReducerProtocol {
    func reduce(state: GameState, event: GameEvent) throws -> GameState
}

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
            state = try validateAction(action: action, state: state)
            state = try processAction(action: action, state: state)
            state = queueTriggeredEffects(state: state)
            state = checkGameOver(state: state)
            return state
        } catch {
            state.error = error as? GameError
            return state
        }
    }
}

private extension GameReducer {

    func validateAction(action: GameAction, state: GameState) throws -> GameState {
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

    func processAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        switch action {
        case .play:
            state = try Play().reduce(state: state, action: action)

        case .forcePlay:
            state = try ForcePlay().reduce(state: state, action: action)

        case .effect:
            state = try EffectReducer().reduce(state: state, action: action)

        default:
            state = try action.reducer().reduce(state: state, action: action)
            state.event = action.toEvent()
        }

        return state
    }
    
    func queueTriggeredEffects(state: GameState) -> State {
        var state = state
        for actor in state.playOrder {
            let actorObj = state.player(actor)
            for card in (actorObj.abilities.union(state.abilities))
            where isTriggered(actor: actor, card: card, state: state) {
                let action = GameAction.forcePlay(actor: actor, card: card)
                state.queue.insert(action, at: 0)
            }
        }
        return state
    }
    
    func isTriggered(actor: String, card: String, state: GameState) -> Bool {
        let ctx = EffectContext(actor: actor, card: card)
        guard let cardObj = state.cardRef[card] else {
            return false
        }
        
        for action in cardObj.actions where
        action.actionType == .trigger {
            for playReq in action.playReqs {
                do {
                    try PlayReqMatcher().match(playReq: playReq, state: state, ctx: ctx)
                } catch {
                    return false
                }
                return true
            }
        }
        return false
    }

    func checkGameOver(state: GameState) -> GameState {
        if let winner = state.hasWinner() {
            var state = state
            state.isOver = GameOver(winner: winner)
            return state
        }

        return state
    }
}

private extension GameAction {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol {
        switch self {
//        case .play: return Play()
//        case .forcePlay: return ForcePlay()
        case .heal: return Heal()
        case .damage: return Damage()
        case .discard: return Discard()
        case .draw: return Draw()
        case .steal: return Steal()
        case .reveal: return Reveal()
        case .chooseCard: return ChooseCard()
        case .groupActions: return GroupActions()
        case .setTurn: return SetTurn()
        case .eliminate: return Eliminate()
        default:
            fatalError(.unexpected)
        }
    }

    func toEvent() -> GameEvent? {
        switch self {
//        case let .play(actor, card, target): return .play(actor: actor, card: card, target: target)
//        case let .forcePlay(actor, card): return .forcePlay(actor: actor, card: card)
        case let .heal(player, value): return .heal(player: player, value: value)
        case let .damage(player, value): return .damage(player: player, value: value)
        case let .discard(player, card): return .discard(player: player, card: card)
        case let .draw(player): return .draw(player: player)
        case let .steal(player, target, card): return .steal(player: player, target: target, card: card)
        case .reveal: return .reveal
        case let .chooseCard(player, card): return .chooseCard(player: player, card: card)
        case let .setTurn(player): return .setTurn(player)
        case let .eliminate(player): return .eliminate(player)
        default: return nil
        }
    }
}
