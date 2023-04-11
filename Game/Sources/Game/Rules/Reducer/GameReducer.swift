//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

typealias GameReducer = (GameState, GameAction) throws -> GameState

let gameReducer: Reducer<GameState, GameAction>
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
            return try playReducer(state, action)

        case .update:
            return try updateReducer(state, action)

        case let .apply(effect, ctx):
            return try effectReducer(effect, state, ctx)

        default:
            fatalError(.unexpected)
        }
    } catch {
        state.thrownError = error as? GameError
        return state
    }
}
