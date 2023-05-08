//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .groupEffects(effects) = effect else {
            fatalError(.unexpected)
        }

        let children = effects.map { $0.withCtx(ctx) }
        return children
    }
}
