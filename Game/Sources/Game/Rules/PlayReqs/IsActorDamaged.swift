//
//  IsActorDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

let isActorDamaged: PlayReqMatcher
= { playReq, state in
    guard case .isActorDamaged = playReq else {
        fatalError(GameError.unexpected)
    }

    return .success
}
