//
//  IsDamaged.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Actor is damaged
struct IsDamaged: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws {
        let actorObj = state.player(ctx.actor)
        guard actorObj.isDamaged else {
            throw GameError.mismatched(.isDamaged)
        }
    }
}
