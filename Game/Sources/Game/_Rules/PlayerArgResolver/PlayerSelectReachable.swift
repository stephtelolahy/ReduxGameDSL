//
//  PlayerSelectReachable.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct PlayerSelectReachable: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let actorObj = state.player(ctx.actor)
        return try PlayerSelectAt(distance: actorObj.weapon)
            .resolve(state: state, ctx: ctx)
    }
}
