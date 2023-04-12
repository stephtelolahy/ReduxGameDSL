//
//  ArgCardResolver.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

// TODO: make arguments readable `arg, state, ctx, chooser, owner`
typealias ArgCardResolver = (ArgCard, GameState, PlayContext, String, String) throws -> ArgOutput

let argCardResolver: ArgCardResolver
= { arg, state, ctx, chooser, owner in
    switch arg {
    case .selectAny:
        return try cardSelectAny(arg, state, ctx, chooser, owner)

    case .selectChoosable:
        return try cardSelectChoosable(arg, state, ctx, chooser, owner)

    default:
        fatalError(.unexpected)
    }
}
