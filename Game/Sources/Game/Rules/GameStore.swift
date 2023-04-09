//
//  GameStore.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux
import Combine

public func createGameStore(initial: GameState) -> Store<GameState, GameAction> {
    Store(initial: initial,
          reducer: gameReducer,
          middlewares: [gameLoopMiddleware])
}

/// Dispatching queued side effects if any
private let gameLoopMiddleware: Middleware<GameState, GameAction> = { state, _ in
    guard !state.queue.isEmpty else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(GameAction.update)
        .eraseToAnyPublisher()
}