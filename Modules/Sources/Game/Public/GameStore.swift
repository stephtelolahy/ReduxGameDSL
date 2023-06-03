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
