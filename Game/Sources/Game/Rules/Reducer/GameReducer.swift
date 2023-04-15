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

public struct GameReducer: ReducerProtocol {
    public init() {}

    public func reduce(state: GameState, action: GameAction) -> GameState {
        if let chooseOne = state.chooseOne {
            guard chooseOne.values.contains(action) else {
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
    func reducer() -> GameReducerProtocol {
        switch self {
        case let .play(actor, card, target):
            return Play(action: self, actor: actor, card: card, target: target)

        case .update:
            return Update()

        case let .apply(effect, ctx):
            switch effect {
            case let .heal(value, player):
                return Heal(action: self, player: player, value: value, ctx: ctx)

            case let .draw(player):
                return Draw(action: self, player: player, ctx: ctx)

            case let .replayEffect(times, effectToRepeat):
                return ReplayEffect(times: times, effect: effectToRepeat, ctx: ctx)

            case let .discard(player, card):
                return Discard(action: self, player: player, card: card, ctx: ctx)

            case let .chooseCard(player, card):
                return ChooseCard(action: self, player: player, card: card, ctx: ctx)

            case .reveal:
                return Reveal(action: self)

            case let .groupEffects(effects):
                return GroupEffects(effects: effects, ctx: ctx)
            }
        }
    }
}
