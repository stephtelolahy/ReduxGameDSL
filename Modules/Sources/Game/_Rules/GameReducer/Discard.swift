//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .discard(player, card) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.discard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: pId) {
                CardEffect.discard(player: player, card: .id($0)).withCtx(ctx)
            }
        }

        var state = state
        try state[keyPath: \GameState.players[pId]]?.removeCard(cId)

        state.discard.push(cId)

        state.event = .discard(player: pId, card: cId)

        return state
    }
}
