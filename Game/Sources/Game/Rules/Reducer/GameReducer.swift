//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

public let gameReducer: Reducer<GameState, GameAction>
= { state, action in

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
        case .play:
            return try PlayReducer().reduce(state: state, action: action)

        case .update:
            return try UpdateReducer().reduce(state: state, action: action)

        case let .apply(effect, ctx):
            switch effect {
            case .heal:
                return try HealReducer().reduce(state: state, action: action)

            case .draw:
                return try DrawReducer().reduce(state: state, action: action)

            case .replayEffect:
                return try ReplayEffectReducer().reduce(state: state, action: action)

            case .discard:
                return try DiscardReducer().reduce(state: state, action: action)

            case .chooseCard:
                return try ChooseCardReducer().reduce(state: state, action: action)
            }
        }
    } catch {
        state.thrownError = error as? GameError
        return state
    }
}
