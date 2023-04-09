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

    switch action {
    case .play:
        return playReducer(state, action)

    case .update:
        return updateReducer(state, action)

    case let .apply(effect, ctx):
        return effectReducer(state, effect, ctx)

    default:
        fatalError(GameError.unexpected)
    }
}
