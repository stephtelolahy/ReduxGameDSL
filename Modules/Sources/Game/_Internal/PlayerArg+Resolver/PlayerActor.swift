//
//  PlayerActor.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct PlayerActor: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: PlayContext) -> PlayerArgOutput {
        .identified([ctx.get(.actor)])
    }
}
