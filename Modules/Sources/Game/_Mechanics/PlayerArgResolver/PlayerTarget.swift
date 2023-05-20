//
//  PlayerTarget.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerTarget: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) -> PlayerArgOutput {
        guard let target = ctx.target else {
            return .identified([])
        }

        return .identified([target])
    }
}
