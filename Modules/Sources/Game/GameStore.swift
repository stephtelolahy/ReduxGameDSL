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
          reducer: GameReducer().reduce,
          middlewares: [GameLoopMiddleware().middleware])
}

/// Dispatching queued side effects
let gameLoopMiddleware: Middleware<GameState, GameAction> = { state, _ in
    guard state.queue.isNotEmpty,
          state.chooseOne == nil else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(GameAction.update)
        .eraseToAnyPublisher()
}
