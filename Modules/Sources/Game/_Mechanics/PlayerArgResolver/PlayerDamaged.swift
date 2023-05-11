//
//  PlayerDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerDamaged: PlayerGroupArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [String] {
        let damaged = state.playOrder
            .starting(with: ctx.actor)
            .filter { state.player($0).isDamaged }

        guard damaged.isNotEmpty else {
            throw GameError.noPlayers(.damaged)
        }

        return damaged
    }
}
