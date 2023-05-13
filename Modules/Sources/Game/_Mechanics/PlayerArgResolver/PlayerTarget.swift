//
//  PlayerTarget.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct PlayerTarget: PlayerArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> PlayerArgOutput {
        guard let target = ctx.target else {
            throw GameError.noPlayer(.target)
        }

        return .identified(target)
    }
}
