//
//  Steal.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct Steal: GameReducerProtocol {
    let player: String
    let target: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state[keyPath: \GameState.players[target]]?.removeCard(card)
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

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
