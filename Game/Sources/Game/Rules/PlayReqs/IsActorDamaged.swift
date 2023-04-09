//
//  IsActorDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

let isActorDamaged: PlayReqMatcher
= { playReq, state, ctx in
    guard case .isActorDamaged = playReq else {
        fatalError(GameError.unexpected)
    }

    let actorObj = state.player(ctx.actor)
    if actorObj.health >= actorObj.maxHealth {
        throw GameError.playerAlreadyMaxHealth(ctx.actor)
    }
}
