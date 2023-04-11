//
//  IsActorDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Actor is damaged
let isActorDamaged: PlayReqMatcher
= { playReq, state, ctx in
    guard case .isActorDamaged = playReq else {
        fatalError(.unexpected)
    }

    let actorObj = state.player(ctx.actor)
    if actorObj.health >= actorObj.maxHealth {
        throw GameError.playerAlreadyMaxHealth(ctx.actor)
    }
}
