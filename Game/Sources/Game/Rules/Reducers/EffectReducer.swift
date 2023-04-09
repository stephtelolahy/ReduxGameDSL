//
//  EffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

typealias EffectReducer = (GameState, CardEffect, PlayContext) throws -> GameState

let effectReducer: EffectReducer
= { state, effect, ctx in
    switch effect {
    case .heal:
        return try healReducer(state, effect, ctx)
        
    default:
        fatalError(GameError.unexpected)
    }
}
