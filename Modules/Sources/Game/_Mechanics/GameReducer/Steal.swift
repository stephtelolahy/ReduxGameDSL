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
    let player: PlayerArg
    let target: PlayerArg
    let card: CardArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .id(pId) = player else {
            return try player.resolve(state: state, ctx: ctx) {
                CardEffect.steal(player: .id($0), target: target, card: card).withCtx(ctx)
            }
        }

        guard case let .id(tId) = target else {
            return try target.resolve(state: state, ctx: ctx) {
                CardEffect.steal(player: player, target: .id($0), card: card).withCtx(ctx)
            }
        }

        return try card.resolve(state: state, ctx: ctx, chooser: ctx.actor, owner: tId) {
            .steal(player: pId, target: tId, card: $0)
        }
    }
}
