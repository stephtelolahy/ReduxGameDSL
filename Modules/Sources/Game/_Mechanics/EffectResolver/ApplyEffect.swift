//
//  ApplyEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct ApplyEffect: EffectResolverProtocol {
    let target: PlayerArg
    let effect: CardEffect
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let targets = try target.resolve(state: state, ctx: ctx)
        guard case let .identified(pIds) = targets else {
            fatalError(.unexpected)
        }
        
        return pIds.map {
            effect.withCtx(EffectContext(actor: ctx.actor, card: ctx.card, target: $0))
        }
    }
}
