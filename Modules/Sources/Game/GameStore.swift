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
          middlewares: [gameLoopMiddleware, actionLoggerMiddleware])
}

private let actionLoggerMiddleware: Middleware<GameState, GameAction> = { _, action in
    print("➡️ \(action)")
    return Empty().eraseToAnyPublisher()
}
