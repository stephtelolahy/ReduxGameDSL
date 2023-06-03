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

        // validate move
        if case .move = action {
            _ = try action.validate(state: state)
        }

        return state
    }

    func executeAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        state = try action.reduce(state: state)
        switch action {
        case .move,
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

        var triggered: [GameAction] = []
        for actor in players {
            let actorObj = state.player(actor)
            for card in (actorObj.abilities + state.abilities) {
                let ctx = EffectContext(actor: actor, card: card)
                if let effect = triggeredEffect(ctx: ctx, state: state) {
                    let sideEffect = effect.withCtx(EffectContext(actor: actor, card: card))
                    triggered.append(sideEffect)
                }
            }
        }
        state.queue.insert(contentsOf: triggered, at: 0)
        
        return state
    }
    
    func triggeredEffect(ctx: EffectContext, state: GameState) -> CardEffect? {
        guard let cardObj = state.cardRef[ctx.card] else {
            return nil
        }
        
        for (eventReq, sideEffect) in cardObj.actions {
            do {
                let eventMatched = try eventReq.match(state: state, ctx: ctx)
                if eventMatched {
                    let gameAction = GameAction.resolve(sideEffect, ctx: ctx)
                    try gameAction.validate(state: state)

                    return sideEffect
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    func updateGameOver(state: GameState) -> GameState {
        if let winner = state.winner() {
            var state = state
            state.isOver = GameOver(winner: winner)
            return state
        }

        return state
    }
}

private extension GameAction {
    func validate(state: GameState) throws {
        var state = try reduce(state: state)
        if state.queue.isNotEmpty {
            let nextAction = state.queue.remove(at: 0)
            switch nextAction {
            case let .chooseOne(_, options):
                if let firstAction = options.first?.value {
                    try firstAction.validate(state: state)
                }

            default:
                try nextAction.validate(state: state)
            }
        }
    }
}