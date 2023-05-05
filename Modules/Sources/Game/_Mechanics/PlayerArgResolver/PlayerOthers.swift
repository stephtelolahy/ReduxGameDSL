//
//  PlayerOthers.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct PlayerOthers: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let others = state.playOrder
            .starting(with: ctx.actor)
            .dropFirst()
        return .identified(Array(others))
    }
}
