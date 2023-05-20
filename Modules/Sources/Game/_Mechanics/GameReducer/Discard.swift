//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    let player: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state[keyPath: \GameState.players[player]]?.removeCard(card)
        state.discard.push(card)
        return state
    }
}

struct EffectDiscard: EffectResolverProtocol {
    let card: CardArg
    var chooser: PlayerArg?
    
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
