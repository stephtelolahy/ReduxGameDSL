//
//  Store+GameState.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import Game
import Redux

func createGameStore(initial: GameState) -> Store<GameState, GameAction> {
    Store(initial: initial,
          reducer: GameState.reducer,
          middlewares: [cardEffectMiddleware])
}
