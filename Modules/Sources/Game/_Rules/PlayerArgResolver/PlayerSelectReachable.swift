//
//  PlayerSelectReachable.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct PlayerSelectReachable: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let actorObj = state.player(ctx.actor)
        return try PlayerSelectAt()
            .resolve(arg: .selectAt(actorObj.weapon), state: state, ctx: ctx)
    }
}
