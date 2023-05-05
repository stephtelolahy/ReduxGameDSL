//
//  PlayerDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerDamaged: PlayerArgResolverProtocol {
    func resolve(arg: PlayerArg, state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let damaged = state.playOrder
            .starting(with: ctx.actor)
            .filter { state.player($0).health < state.player($0).maxHealth }

        guard damaged.isNotEmpty else {
            throw GameError.noPlayerDamaged
        }

        return .identified(damaged)
    }
}
