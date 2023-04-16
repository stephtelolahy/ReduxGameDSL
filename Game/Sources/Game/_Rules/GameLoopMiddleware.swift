//
//  GameLoopMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//
import Combine

/// Dispatching queued side effects
struct GameLoopMiddleware {
    func middleware(state: GameState, action: GameAction) -> AnyPublisher<GameAction, Never> {
        guard state.queue.isNotEmpty,
              state.chooseOne == nil else {
            return Empty()
                .eraseToAnyPublisher()
        }

        return Just(GameAction.update)
            .eraseToAnyPublisher()
    }
}
