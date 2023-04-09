//
//  HealReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let healReducer: Reducer<GameState, GameAction>
= { state, action in
    guard case let .apply(effect) = action,
          case let .heal(value, player) = effect else {
        fatalError(GameError.unexpected)
    }

    var state = state
    guard case let .id(pId) = player else {
        // TODO: resolve player
        state.queue.insert(.heal(value, player: .id("p1")), at: 0)
        return state
    }

    do {
        // update health
        try state.updatePlayer(pId) { playerObj in
            try playerObj.gainHealth(value)
        }
        
        state.completedAction = action
    } catch {
        state.thrownError = (error as? GameError).unsafelyUnwrapped
    }

    return state
}
