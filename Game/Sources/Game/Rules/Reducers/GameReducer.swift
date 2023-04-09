//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

public let gameReducer: Reducer<GameState, GameAction>
= { state, action in
    var state = state
    state.completedAction = nil
    state.thrownError = nil

    switch action {
    case .play:
        return playReducer(state, action)

    case .update:
        return updateReducer(state, action)

    case .apply:
        return effectReducer(state, action)

    default:
        fatalError(GameError.unexpected)
    }
}
