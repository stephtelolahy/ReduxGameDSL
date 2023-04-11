//
//  EffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

public typealias EffectReducer = (CardEffect, GameState, PlayContext) throws -> GameState

public let effectReducer: EffectReducer
= { effect, state, ctx in
    switch effect {
    case .heal:
        return try healReducer(effect, state, ctx)

    case .drawDeck:
        return try drawDeckReducer(effect, state, ctx)

    case .replayEffect:
        return try replayEffectReducer(effect, state, ctx)

    case .discard:
        return try discardReducer(effect, state, ctx)

    case .chooseCard:
        return try chooseCardReducer(effect, state, ctx)
        
    default:
        fatalError(.unexpected)
    }
}
