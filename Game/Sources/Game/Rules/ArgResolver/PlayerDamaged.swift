//
//  PlayerDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerDamaged: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> ArgOutput {
        let damaged = state.playOrder
            .starting(with: ctx.actor)
            .filter { state.player($0).health < state.player($0).maxHealth }

        guard damaged.isNotEmpty else {
            throw GameError.noPlayerDamaged
        }

        return .identified(damaged)
    }
}
