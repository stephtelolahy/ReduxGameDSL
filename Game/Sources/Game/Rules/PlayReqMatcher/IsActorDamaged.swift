//
//  IsActorDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Actor is damaged
struct IsActorDamaged: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: PlayContext) throws {
        let actorObj = state.player(ctx.actor)
        if actorObj.health >= actorObj.maxHealth {
            throw GameError.playerAlreadyMaxHealth(ctx.actor)
        }
    }
}
