//
//  PlayerTarget.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerTarget: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: PlayContext) -> PlayerArgOutput {
        .identified([ctx.get(.target)])
    }
}
