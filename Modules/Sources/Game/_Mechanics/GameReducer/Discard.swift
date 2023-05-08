//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .discard(player, card) = action else {
            fatalError(.unexpected)
        }

        var state = state
        try state[keyPath: \GameState.players[player]]?.removeCard(card)
        state.discard.push(card)
        return state
    }
}

extension Discard: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .discard(player, card) = effect else {
            fatalError(.unexpected)
        }

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
                CardEffect.discard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        return try CardArgResolver().resolving(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: pId) {
            .discard(player: pId, card: $0)
        }
    }
}
