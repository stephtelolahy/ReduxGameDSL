//
//  EffectDiscard.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//

@available(*, deprecated, message: "")
struct EffectDiscard: EffectResolverProtocol {
    let card: CardArg
    let chooser: PlayerArg?

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let target = try ctx.getTarget()

        var chooserId = target
        if let chooser {
            guard case let .id(cId) = chooser else {
                return try chooser.resolve(state: state, ctx: ctx) {
                    CardEffect.discard(card, chooser: .id($0)).withCtx(ctx)
                }
            }
            chooserId = cId
        }

        return try card.resolve(state: state, ctx: ctx, chooser: chooserId, owner: target) {
            .discard(player: target, card: $0)
        }
    }
}
