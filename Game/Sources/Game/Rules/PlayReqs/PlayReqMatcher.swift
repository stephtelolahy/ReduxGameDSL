//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias PlayReqMatcher = (PlayReq, GameState, PlayContext) -> Result<Void, GameError>

let matchPlayReq: PlayReqMatcher
= { playReq, state, ctx in
    switch playReq {
    case .isPlayersAtLeast:
        return isPlayersAtLeast(playReq, state, ctx)

    case .isActorDamaged:
        return isActorDamaged(playReq, state, ctx)

    default:
        fatalError(GameError.unexpected)
    }
}
