//
//  EffectSteal.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//

@available(*, deprecated, message: "")
struct EffectSteal: EffectResolverProtocol {
    let card: CardArg
    let stealer: PlayerArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let target = try ctx.getTarget()

        guard case let .id(pId) = stealer else {
            return try stealer.resolve(state: state, ctx: ctx) {
                CardEffect.steal(card, stealer: .id($0)).withCtx(ctx)
            }
        }

        return try card.resolve(state: state, ctx: ctx, chooser: pId, owner: target) {
            .steal(player: pId, target: target, card: $0)
        }
    }
}
