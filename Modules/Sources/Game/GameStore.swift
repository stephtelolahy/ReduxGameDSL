//
//  GameStore.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux
import Combine

func createGameStore(initial: GameState) -> Store<GameState, GameAction> {
    Store(initial: initial,
          reducer: GameReducer().reduce,
          middlewares: [gameLoopMiddleware, eventLoggerMiddleware])
}

private let eventLoggerMiddleware: Middleware<GameState, GameAction> = { state, _ in
    if #available(macOS 13.0, *) {
        print("➡️ \(String(describing: state.event))".replacing("Game.GameEvent.", with: ""))
    } else {
        // Fallback on earlier versions
    }
    return Empty().eraseToAnyPublisher()
}
