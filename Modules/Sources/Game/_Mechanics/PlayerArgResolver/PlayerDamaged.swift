//
//  PlayerDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerDamaged: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let damaged = state.playOrder
            .starting(with: ctx.actor)
            .filter { state.player($0).isDamaged }

        guard damaged.isNotEmpty else {
            throw GameError.noPlayer(.damaged)
        }

        return .identified(damaged)
    }
}
