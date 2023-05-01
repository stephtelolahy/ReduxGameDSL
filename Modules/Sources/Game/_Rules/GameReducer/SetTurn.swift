//
//  SetTurn.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct SetTurn: GameReducerProtocol {
    let player: PlayerArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.setTurn(.id($0)).withCtx(ctx)
            }
        }

        var state = state
        state.turn = pId
        state.counters = [:]
        state.event = .setTurn(pId)

        return state
    }
}
