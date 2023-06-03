//
//  EffectChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//

@available(*, deprecated, message: "")
struct EffectChooseCard: EffectResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let target = try ctx.getTarget()

        return try CardArg.selectArena.resolve(state: state, ctx: ctx, chooser: target, owner: nil) {
            .chooseCard(player: target, card: $0)
        }
    }
}
