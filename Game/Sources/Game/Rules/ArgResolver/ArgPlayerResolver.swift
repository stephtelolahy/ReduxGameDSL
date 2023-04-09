//
//  ArgPlayerResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias ArgPlayerResolver = (ArgPlayer, GameState, PlayContext) throws -> ArgOutput

let argPlayerResolver: ArgPlayerResolver
= { arg, state, ctx in
    switch arg {
    case .actor:
        return try playerActor(arg, state, ctx)
        
    default:
        fatalError(GameError.unexpected)
    }
}
