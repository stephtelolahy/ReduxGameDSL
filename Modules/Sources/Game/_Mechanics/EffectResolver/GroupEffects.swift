//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: EffectResolverProtocol {
    let effects: [CardEffect]
    
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        effects.map { $0.withCtx(ctx) }
    }
}
