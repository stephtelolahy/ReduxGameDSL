//
//  PlayerOthers.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct PlayerOthers: PlayerGroupArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [String] {
        let others = state.playOrder
            .starting(with: ctx.actor)
            .dropFirst()
        return Array(others)
    }
}
