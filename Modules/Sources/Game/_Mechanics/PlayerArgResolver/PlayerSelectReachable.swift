//
//  PlayerSelectReachable.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct PlayerSelectReachable: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let actorObj = state.player(ctx.actor)
        let range = actorObj.attributes[.weapon] ?? 0
        return try PlayerSelectAt()
            .resolve(arg: .selectAt(range), state: state, ctx: ctx)
    }
}
