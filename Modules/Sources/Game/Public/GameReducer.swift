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

        do {
            state = try prepare(action: action, state: state)
            state = try action.reduce(state: state)
            state.event = action
            state = postExecute(action: action, state: state)
        } catch {
            if let gameError = error as? GameError {
                state.event = .error(gameError)
            }
        }

        return state
    }
}

private extension GameReducer {

    func prepare(action: GameAction, state: GameState) throws -> GameState {
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

        // validate play
        if case .play = action {
            _ = try action.validate(state: state)
        }
        
        // remove active
        state.active = nil

        return state
    }

    func postExecute(action: GameAction, state: GameState) -> State {
        var state = state
        queueTriggered(state: &state)
        updateGameOver(state: &state)
        return state
    }
    
    func queueTriggered(state: inout GameState) {
        var players = state.playOrder
        if case let .eliminate(justEliminated) = state.event {
            players.append(justEliminated)
        }
        
        var triggered: [GameAction] = []
        for actor in players {
            let actorObj = state.player(actor)
            for card in (actorObj.inPlay.cards + actorObj.abilities + state.abilities) {
                if let triggeredAction = triggeredAction(by: card, actor: actor, state: state) {
                    triggered.append(triggeredAction)
                }
            }
        }
        state.queue.insert(contentsOf: triggered, at: 0)
    }

    func triggeredAction(by card: String, actor: String, state: GameState) -> GameAction? {
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName] else {
            return nil
        }
        
        for action in cardObj.actions {
            do {
                let ctx: EffectContext = [.actor: actor, .card: card]
                let eventMatched = try action.eventReq.match(state: state, ctx: ctx)
                if eventMatched {
                    let sideEffect = action.effect
                    let gameAction = GameAction.resolve(sideEffect, ctx: ctx)
                    try gameAction.validate(state: state)
                    
                    return gameAction
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    func updateGameOver(state: inout GameState) {
        if case .eliminate = state.event,
           let winner = state.evaluateWinner() {
            state.isOver = GameOver(winner: winner)
        }
    }
}

extension GameAction {
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
    
    var isRenderable: Bool {
        switch self {
        case .play,
             .resolve,
             .group:
            return false

        default:
            return true
        }
    }
}
