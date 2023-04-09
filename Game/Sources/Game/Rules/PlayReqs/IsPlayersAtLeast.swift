//
//  IsPlayersAtLeast.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

let isPlayersAtLeast: PlayReqMatcher
= { playReq, state, _ in
    guard case let .isPlayersAtLeast(count) = playReq else {
        fatalError(GameError.unexpected)
    }

    guard state.players.count >= count else {
        return .failure(GameError.playersMustBeAtLeast(count))
    }

    return .success
}
