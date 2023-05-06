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

struct GameReducer: ReducerProtocol {
    func reduce(state: GameState, action: GameAction) -> GameState {
        guard state.isOver == nil else {
            return state
        }

        var state = state
        state = queueTriggeredEffects(state: state)

        do {
            state = try validateAction(action: action, state: state)

            return try action.reducer().reduce(state: state, action: action)
        } catch {
            state.error = error as? GameError
            return state
        }
    }
    
    private func queueTriggeredEffects(state: GameState) -> State {
        var state = state
        for actor in state.playOrder {
            let actorObj = state.player(actor)
            for card in actorObj.abilities
            where isTriggered(actor: actor, card: card, state: state) {
                let action = GameAction.forcePlay(actor: actor, card: card)
                state.queue.insert(action, at: 0)
            }
        }
        
        state.event = nil
        state.error = nil
        return state
    }
    
    private func isTriggered(actor: String, card: String, state: GameState) -> Bool {
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
    
    private func validateAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        if let chooseOne = state.chooseOne {
            guard chooseOne.options.values.contains(action) else {
                throw GameError.unwaitedAction
            }
            state.chooseOne = nil
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
            
        case .update: return Update()
            
        case let .effect(effect, _):
            switch effect {
            case .draw: return Draw()
                
            case .discard: return Discard()
                
            case .steal: return Steal()
                
            case .reveal: return Reveal()
                
            case .heal: return Heal()
                
            case .damage: return Damage()
                
            case .forceDiscard: return ForceDiscard()
                
            case .challengeDiscard: return ChallengeDiscard()
                
            case .setTurn: return SetTurn()

            case .eliminate: return Eliminate()
                
            case .chooseCard: return ChooseCard()
                
            case .applyEffect: return ApplyEffect()
                
            case .replayEffect: return ReplayEffect()
                
            case .groupEffects: return GroupEffects()
            }
        }
    }
}
