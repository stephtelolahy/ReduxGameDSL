//
//  Store+GameState.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import Redux

public func createGameStore(initial: GameState) -> Store<GameState, GameAction> {
    Store(initial: initial,
          reducer: GameState.reducer,
          middlewares: [cardEffectMiddleware])
}
