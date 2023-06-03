//
//  EffectCard.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//

struct EffectCard: EffectResolverProtocol {
    let card: CardArg
    let effect: CardEffect

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let chooser = ctx.getTarget()
        let owner = ctx.getTarget()
        return try card.resolve(state: state, ctx: ctx, chooser: chooser, owner: owner) {
            .resolve(effect, ctx: ctx.copy(cardSelected: $0))
        }
    }
}
