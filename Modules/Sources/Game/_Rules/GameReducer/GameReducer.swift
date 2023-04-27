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
        if let chooseOne = state.chooseOne {
            guard chooseOne.options.values.contains(action) else {
                return state
            }
        }

        var state = state
        state.completedAction = nil
        state.thrownError = nil
        state.chooseOne = nil

        do {
            return try action.reducer().reduce(state: state)
        } catch {
            state.thrownError = error as? GameError
            return state
        }
    }
}

private extension GameAction {
    // swiftlint:disable:next cyclomatic_complexity
    func reducer() -> GameReducerProtocol {
        switch self {
        case let .play(actor, card, target):
            return Play(action: self, actor: actor, card: card, target: target)

        case .update:
            return Update()

        case let .heal(value, player, ctx):
            return Heal(player: player, value: value, ctx: ctx)

        case let .damage(value, player, ctx):
            return Damage(player: player, value: value, ctx: ctx)

        case let .draw(player, ctx):
            return Draw(player: player, ctx: ctx)

        case let .discard(player, card, ctx):
            return Discard(action: self, player: player, card: card, ctx: ctx!)

        case let .steal(player, target, card, ctx):
            return Steal(action: self, player: player, target: target, card: card, ctx: ctx!)

        case let .chooseCard(player, card, ctx):
            return ChooseCard(action: self, player: player, card: card, ctx: ctx!)

        case .reveal:
            return Reveal(action: self)
            
        case let .forceDiscard(player, card, otherwise, ctx):
            return ForceDiscard(action: self, player: player, card: card, otherwise: otherwise, ctx: ctx!)

        case let .challengeDiscard(player, card, otherwise, challenger, ctx):
            return ChallengeDiscard(action: self,
                                    player: player,
                                    card: card,
                                    otherwise: otherwise,
                                    challenger: challenger,
                                    ctx: ctx!)

        case let .replayEffect(times, effectToRepeat, ctx):
            return ReplayEffect(times: times, effect: effectToRepeat, ctx: ctx!)

        case let .groupEffects(effects, ctx):
            return GroupEffects(effects: effects, ctx: ctx!)

        case let .applyEffect(target, effect, ctx):
            return ApplyEffect(target: target, effect: effect, ctx: ctx!)
        }
    }
}
