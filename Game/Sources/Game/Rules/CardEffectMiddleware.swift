//
//  CardEffectMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

import Redux
import Combine

/// Apply card side effects
class CardEffectMiddleware {

    let middleware: Middleware<GameState, GameAction> = { _, _ in
        Empty()
            .eraseToAnyPublisher()
    }
}
