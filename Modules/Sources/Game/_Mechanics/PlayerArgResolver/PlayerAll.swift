//
//  PlayerAll.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct PlayerAll: PlayerGroupArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [String] {
        state.playOrder
            .starting(with: ctx.actor)
    }
}
