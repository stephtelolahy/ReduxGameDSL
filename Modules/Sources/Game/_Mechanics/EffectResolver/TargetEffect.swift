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
        let resolved = try target.resolve(state: state, ctx: ctx)
        guard case let .identified(pIds) = resolved else {
            fatalError(.unexpected)
        }

        return pIds.map {
            effect.withCtx(EffectContext(actor: ctx.actor, card: ctx.card, target: $0))
        }
    }
}
