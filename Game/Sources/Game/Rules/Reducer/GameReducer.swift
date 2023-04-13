//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

public struct GameReducer: ReducerProtocol {
    public init() {}

    // swiftlint:disable:next cyclomatic_complexity line_length
    public func reduce(state: GameState, action: GameAction) -> GameState {
        if let expected = state.chooseOne {
            guard expected.contains(action) else {
                return state
            }
        }

        var state = state
        state.completedAction = nil
        state.thrownError = nil
        state.chooseOne = nil

        do {
            switch action {
            case let .play(actor, card, target):
                return try PlayReducer(action: action, actor: actor, card: card, target: target).reduce(state)

            case .update:
                return try UpdateReducer().reduce(state: state, action: action)

            case let .apply(effect, ctx):
                switch effect {
                case let .heal(value, player):
                    return try HealReducer(action: action, player: player, value: value, ctx: ctx).reduce(state)

                case .draw:
                    return try DrawReducer().reduce(state: state, action: action)

                case .replayEffect:
                    return try ReplayEffectReducer().reduce(state: state, action: action)

                case .discard:
                    return try DiscardReducer().reduce(state: state, action: action)

                case let .chooseCard(player, card):
                    return try ChooseCardReducer(action: action, player: player, card: card, ctx: ctx).reduce(state)
                }
            }
        } catch {
            state.thrownError = error as? GameError
            return state
        }
    }
}
