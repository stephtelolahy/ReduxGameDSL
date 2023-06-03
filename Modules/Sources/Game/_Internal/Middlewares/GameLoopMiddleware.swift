//
//  GameLoopMiddleware.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 26/04/2023.
//
import Redux
import Combine

/// Dispatching queued side effects
let gameLoopMiddleware: Middleware<GameState, GameAction> = { state, _ in
    guard state.isOver == nil,
          state.chooseOne == nil,
          state.queue.isNotEmpty else {
        return Empty()
            .eraseToAnyPublisher()
    }
    
    return Just(state.queue[0])
        .eraseToAnyPublisher()
}
