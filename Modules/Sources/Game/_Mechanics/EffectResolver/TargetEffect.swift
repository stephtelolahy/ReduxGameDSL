//
//  TargetEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct TargetEffect: EffectResolverProtocol {
    let target: PlayerArg
    let effect: CardEffect
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try target.resolve(state: state, ctx: ctx) {
            .resolve(effect, ctx: EffectContext(actor: ctx.actor, card: ctx.card, target: $0))
        }
    }
}
