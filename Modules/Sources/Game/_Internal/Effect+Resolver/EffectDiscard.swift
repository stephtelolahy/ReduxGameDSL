//
//  EffectDiscard.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 20/06/2023.
//

struct EffectDiscard: EffectResolverProtocol {
    let card: CardArg
    let chooser: PlayerArg?
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        let owner = ctx.get(.target)
        var chooserId = owner
        if let chooser {
            if case let .id(cId) = chooser {
                chooserId = cId
            } else {
                let output = try chooser.resolve(state: state, ctx: ctx)
                guard case let .identified(pIds) = output else {
                    fatalError("unexpected")
                }

                guard pIds.count == 1 else {
                    fatalError("unexpected")
                }

                chooserId = pIds[0]
            }
        }

        return try card.resolve(state: state, ctx: ctx, chooser: chooserId, owner: owner) {
            .discard($0, player: owner)
        }
    }
}
