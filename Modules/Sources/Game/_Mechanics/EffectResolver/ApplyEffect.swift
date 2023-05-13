//
//  ApplyEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct ApplyEffect: EffectResolverProtocol {
    let target: PlayerGroupArg
    let effect: CardEffect
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let pIds = try target.resolve(state: state, ctx: ctx)
        return pIds.map {
            effect.withCtx(EffectContext(actor: ctx.actor, card: ctx.card, target: $0))
        }
    }
}
