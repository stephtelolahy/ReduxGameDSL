//
//  Draw.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Draw: GameReducerProtocol {
    let player: PlayerArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.draw(player: .id($0)).withCtx(ctx)
            }
        }

        var state = state
        let card = try state.popDeck()
        state[keyPath: \GameState.players[pId]]?.hand.add(card)

        state.event = .draw(player: pId)

        return state
    }
}
