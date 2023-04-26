//
//  PlayerSelectAny.swift
//  
//
//  Created by Hugues Telolahy on 26/04/2023.
//

struct PlayerSelectAny: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        let others = state.playOrder
            .starting(with: ctx.actor)
            .dropFirst()
        return .selectable(Array(others))
    }
}