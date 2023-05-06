//
//  NumPlayerAttr.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 02/05/2023.
//

struct NumPlayerAttr: NumArgResolverProtocol {
    func resolve(arg: NumArg, state: GameState, ctx: EffectContext) throws -> Int {
        guard case let .playerAttr(key) = arg else {
            fatalError(.unexpected)
        }

        let actorObj = state.player(ctx.actor)
        return actorObj.attributes[key] ?? 0
    }
}
