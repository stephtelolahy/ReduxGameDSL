//
//  IsAnyDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

/// Any player damaged
let isAnyDamaged: PlayReqMatcher
= { playReq, state, _ in
    guard case .isAnyDamaged = playReq else {
        fatalError(.unexpected)
    }

    if state.players.allSatisfy({ $0.health >= $0.maxHealth }) {
        throw GameError.noPlayerDamaged
    }
}
