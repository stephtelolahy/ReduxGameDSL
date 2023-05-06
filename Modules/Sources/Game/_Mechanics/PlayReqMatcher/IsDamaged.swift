//
//  IsDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Actor is damaged
struct IsDamaged: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        let actorObj = state.player(ctx.actor)
        if actorObj.health >= actorObj.maxHealth {
            throw GameError.mismatched(playReq)
        }
    }
}
