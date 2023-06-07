//
//  PlayerOthers.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct PlayerOthers: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: [ContextKey: String]) -> PlayerArgOutput {
        let others = state.playOrder
            .starting(with: ctx.get(.actor))
            .dropFirst()
        return .identified(Array(others))
    }
}
