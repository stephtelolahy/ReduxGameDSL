//
//  Steal.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct Steal: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .steal(player, target, card) = action else {
            fatalError(.unexpected)
        }

        var state = state
        try state[keyPath: \GameState.players[target]]?.removeCard(card)
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

extension Steal: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .steal(player, target, card) = effect else {
            fatalError(.unexpected)
        }

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
                CardEffect.steal(player: .id($0), target: target, card: card).withCtx(ctx)
            }
        }

        guard case let .id(tId) = target else {
            return try PlayerArgResolver().resolving(arg: target, state: state, ctx: ctx) {
                CardEffect.steal(player: player, target: .id($0), card: card).withCtx(ctx)
            }
        }

        return try CardArgResolver().resolving(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: tId) {
            .steal(player: pId, target: tId, card: $0)
        }
    }
}
