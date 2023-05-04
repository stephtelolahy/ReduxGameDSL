//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

protocol GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState
}

struct GameReducer: ReducerProtocol {
    func reduce(state: GameState, action: GameAction) -> GameState {
        var state = state

        queueTriggeredEffects(state: &state)

        state.event = nil
        state.error = nil

        if let chooseOne = state.chooseOne {
            guard chooseOne.options.values.contains(action) else {
                state.error = .unwaitedAction
                return state
            }
            state.chooseOne = nil
        }

        do {
            return try action.reducer().reduce(state: state)
        } catch {
            state.error = error as? GameError
            return state
        }
    }

    private func queueTriggeredEffects(state: inout GameState) {
        for actor in state.playOrder {
            let actorObj = state.player(actor)
            for card in actorObj.abilities
            where isTriggered(actor: actor, card: card, state: state) {
                let action = GameAction.invoke(actor: actor, card: card)
                state.queue.insert(action, at: 0)
            }
        }
    }

    private func isTriggered(actor: String, card: String, state: GameState) -> Bool {
        let ctx = EffectContext(actor: actor, card: card)
        guard let cardObj = state.cardRef[card] else {
            return false
        }

        for action in cardObj.actions where
        action.actionType == .play {
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
}

private extension GameAction {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol {
        switch self {
        case let .play(actor, card, target):
            return Play(actor: actor, card: card, target: target)

        case let .invoke(actor, card):
            return Invoke(actor: actor, card: card)

        case .update:
            return Update()

        case let .effect(effect, ctx):
            switch effect {
            case let .heal(value, player):
                return Heal(player: player, value: value, ctx: ctx)

            case let .damage(value, player):
                return Damage(player: player, value: value, ctx: ctx)

            case let .draw(player):
                return Draw(player: player, ctx: ctx)

            case let .discard(player, card):
                return Discard(player: player, card: card, ctx: ctx)

            case let .steal(player, target, card):
                return Steal(player: player, target: target, card: card, ctx: ctx)

            case let .chooseCard(player, card):
                return ChooseCard(player: player, card: card, ctx: ctx)

            case .reveal:
                return Reveal()

            case let .forceDiscard(player, card, otherwise):
                return ForceDiscard(player: player, card: card, otherwise: otherwise, ctx: ctx)

            case let .challengeDiscard(player, card, otherwise, challenger):
                return ChallengeDiscard(player: player,
                                        card: card,
                                        otherwise: otherwise,
                                        challenger: challenger,
                                        ctx: ctx)

            case let .setTurn(player):
                return SetTurn(player: player, ctx: ctx)

            case let .replayEffect(times, effectToRepeat):
                return ReplayEffect(times: times, effect: effectToRepeat, ctx: ctx)

            case let .groupEffects(effects):
                return GroupEffects(effects: effects, ctx: ctx)

            case let .applyEffect(target, effect):
                return ApplyEffect(target: target, effect: effect, ctx: ctx)
            }
        }
    }
}
