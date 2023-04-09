//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias PlayReqMatcher = (PlayReq, GameState, PlayContext) throws -> Void

let matchPlayReq: PlayReqMatcher
= { playReq, state, ctx in
    switch playReq {
    case .isPlayersAtLeast:
        try isPlayersAtLeast(playReq, state, ctx)

    case .isActorDamaged:
        try isActorDamaged(playReq, state, ctx)

    default:
        fatalError(GameError.unexpected)
    }
}
