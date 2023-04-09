//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

typealias GameReducer = Reducer<GameState, GameAction>

let gameReducer: GameReducer
= { state, action in
    var state = state
    state.completedAction = nil
    state.thrownError = nil

    do {
        switch action {
        case .play:
            return playReducer(state, action)

        case .update:
            return updateReducer(state, action)

        case let .apply(effect, ctx):
            return try effectReducer(state, effect, ctx)

        default:
            fatalError(GameError.unexpected)
        }
    } catch {
        state.thrownError = (error as? GameError).unsafelyUnwrapped
        return state
    }
}
