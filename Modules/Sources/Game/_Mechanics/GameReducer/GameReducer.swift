//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

@available(*, deprecated, message: "EffectResolverProtocol")
protocol GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState
}

protocol EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput
}

enum EffectOutput {
    case actions([GameAction])
    case chooseOne(ChooseOne)
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

            switch action {
            case .play:
                state = try Play().reduce(state: state, action: action)

            case .forcePlay:
                state = try ForcePlay().reduce(state: state, action: action)

            case let .effect(effect, ctx):

                if let reduer = effect.reducer() {
                    state = try reduer.reduce(state: state, action: action)
                } else {
                    let result = try effect.resolver().resolve(effect: effect, state: state, ctx: ctx)
                    switch result {
                    case let .actions(actions):
                        state.queue.insert(contentsOf: actions, at: 0)

                    case let .chooseOne(chooseOne):
                        state.chooseOne = chooseOne
                        state.event = .chooseOne(chooser: chooseOne.chooser, options: Set(chooseOne.options.keys))
                    }
                }
                
            case let .event(event):
                state = try event.reducer().reduce(state: state, event: event)
                state.event = event
            }

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

extension CardEffect {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol? {
        switch self {
        case .draw: return Draw()

        case .steal: return Steal()

        case .reveal: return Reveal()

        case .forceDiscard: return ForceDiscard()

        case .challengeDiscard: return ChallengeDiscard()

        case .setTurn: return SetTurn()

        case .eliminate: return Eliminate()

        case .chooseCard: return ChooseCard()

        case .applyEffect: return ApplyEffect()

        case .replayEffect: return ReplayEffect()

        case .groupEffects: return GroupEffects()

        default:
            return nil
        }
    }

    func resolver() -> EffectResolverProtocol {
        switch self {
        case .heal: return Heal()

        case .damage: return Damage()

        case .discard: return Discard()

        default:
            fatalError(.unexpected)
        }
    }
}

extension GameEvent {
    func reducer() -> EventReducerProtocol {
        switch self {
        case .heal: return Heal()

        case .damage: return Damage()

        case .discard: return Discard()

        default:
            fatalError(.unexpected)
        }
    }
}
