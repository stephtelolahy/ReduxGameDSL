//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias PlayReqMatcher = (PlayReq, GameState) -> Result<Void, GameError>

let matchPlayReq: PlayReqMatcher
= { playReq, state in
    switch playReq {
    case .isPlayersAtLeast:
        return isPlayersAtLeast(playReq, state)

    case .isActorDamaged:
        return isActorDamaged(playReq, state)

    default:
        fatalError(GameError.unexpected)
    }
}
