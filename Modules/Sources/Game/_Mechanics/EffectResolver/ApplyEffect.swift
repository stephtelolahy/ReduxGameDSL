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
        let targets = try PlayerArgResolver().resolve(arg: target, state: state, ctx: ctx)
        guard case let .identified(pIds) = targets else {
            fatalError(GameError.unexpected)
        }
        
        return pIds.map {
            self.effect.withCtx(EffectContext(actor: ctx.actor, card: ctx.card, target: $0))
        }
    }
}
