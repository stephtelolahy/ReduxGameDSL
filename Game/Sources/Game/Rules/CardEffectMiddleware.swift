//
//  CardEffectMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

import Redux
import Combine

/// Apply card side effects
public let cardEffectMiddleware: Middleware<GameState, GameAction> = { _, action in
    guard case let .play(actor, card) = action else {
        return Empty().eraseToAnyPublisher()
    }

    return Just(GameAction.apply(.heal(1, player: .id(actor))))
        .eraseToAnyPublisher()
}
