//
//  PlayerTarget.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerTarget: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: [ContextKey: String]) -> PlayerArgOutput {
        .identified([ctx.get(.target)])
    }
}
