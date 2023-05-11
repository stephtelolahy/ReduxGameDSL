//
//  IsDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Actor is damaged
struct IsDamaged: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws -> Bool {
        let actorObj = state.player(ctx.actor)
        return actorObj.isDamaged
    }
}
