//
//  ArgPlayerResolver.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias ArgPlayerResolver = (ArgPlayer, GameState, PlayContext) -> Result<ArgOutput, GameError>

let argPlayerResolver: ArgPlayerResolver
= { arg, state, ctx in
    switch arg {
    case .actor:
        return playerActor(arg, state, ctx)
        
    default:
        fatalError(GameError.unexpected)
    }
}
