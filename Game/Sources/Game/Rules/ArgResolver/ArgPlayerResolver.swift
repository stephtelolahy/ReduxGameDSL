//
//  ArgPlayerResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias ArgPlayerResolver = (PlayerArg, GameState, EffectContext) throws -> ArgOutput

let argPlayerResolver: ArgPlayerResolver
= { arg, state, ctx in
    switch arg {
    case .actor:
        return try playerActor(arg, state, ctx)

    case .damaged:
        return try playerDamaged(arg, state, ctx)

    case .target:
        return try playerTarget(arg, state, ctx)

    case .selectAnyWithCard:
        return try playerSelectAnyWithCard(arg, state, ctx)
        
    default:
        fatalError(.unexpected)
    }
}
