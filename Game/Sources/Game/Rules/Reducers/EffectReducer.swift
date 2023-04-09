//
//  EffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let effectReducer: Reducer<GameState, GameAction>
= { state, action in
    guard case let .apply(effect) = action else {
        fatalError(GameError.unexpected)
    }

    switch effect {
    case .heal:
        return healReducer(state, action)
        
    default:
        fatalError(GameError.unexpected)
    }
}
