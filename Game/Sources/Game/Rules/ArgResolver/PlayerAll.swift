//
//  PlayerAll.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct PlayerAll: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> ArgOutput {
        let all = state.playOrder
            .starting(with: ctx.actor)
        return .identified(all)
    }
}
