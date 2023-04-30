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
    guard state.queue.isNotEmpty,
          state.chooseOne == nil else {
        return Empty()
            .eraseToAnyPublisher()
    }
    
    return Just(.update)
        .eraseToAnyPublisher()
}
