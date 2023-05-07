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
            state = queueTriggeredEffects(state: state)
            state = updateGameOver(state: state)
        } catch {
            state.error = error as? GameError
        }

        return state
    }
}

private extension GameReducer {

    func executeAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        state = try action.reducer().reduce(state: state, action: action)
        switch action {
        case .play, .effect, .chooseOne, .groupActions:
            break

        default:
            state.event = action
        }
        return state
    }

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

    func updateGameOver(state: GameState) -> GameState {
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
        case .play: return Play()
        case .forcePlay: return ForcePlay()
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
        case .effect: return EffectReducer()
        case .chooseOne: fatalError(.unexpected)
        }
    }
}
