//
//  Steal.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct Steal: GameReducerProtocol {
    let player: PlayerArg
    let target: PlayerArg
    let card: CardArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.steal(player: .id($0), target: target, card: card).withCtx(ctx)
            }
        }

        guard case let .id(tId) = target else {
            return try PlayerArgResolver().resolve(arg: target, state: state, ctx: ctx) {
                CardEffect.steal(player: player, target: .id($0), card: card).withCtx(ctx)
            }
        }

        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: ctx.actor, owner: tId) {
                CardEffect.steal(player: player, target: target, card: .id($0)).withCtx(ctx)
            }
        }

        try state[keyPath: \GameState.players[tId]]?.removeCard(cId)

        state[keyPath: \GameState.players[pId]]?.hand.add(cId)

        state.event = .success(.steal(player: pId, target: tId, card: cId)) 

        return state
    }
}
