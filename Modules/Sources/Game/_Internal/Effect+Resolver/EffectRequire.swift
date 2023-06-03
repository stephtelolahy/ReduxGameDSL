//
//  EffectRequire.swift
//  
//
//  Created by Hugues Telolahy on 18/05/2023.
//

struct EffectRequire: EffectResolverProtocol {
    let playReqs: [PlayReq]
    let effect: CardEffect

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        for playReq in playReqs {
            try playReq.match(state: state, ctx: ctx)
        }
        return [effect.withCtx(ctx)]
    }
}
