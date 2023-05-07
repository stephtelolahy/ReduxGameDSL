//
//  ApplyEffect.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

struct ApplyEffect: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .applyEffect(target, effect) = effect else {
            fatalError(.unexpected)
        }
        
        let targets = try PlayerArgResolver().resolve(arg: target, state: state, ctx: ctx)
        guard case let .identified(pIds) = targets else {
            fatalError(GameError.unexpected)
        }

        let children = pIds.map {
            effect.withCtx(EffectContext(actor: ctx.actor,
                                         card: ctx.card,
                                         target: $0))
        }
        return .actions(children)
    }
}
