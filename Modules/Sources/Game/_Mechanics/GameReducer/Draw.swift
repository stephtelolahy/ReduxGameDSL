//
//  Draw.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Draw: GameReducerProtocol {
    let player: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        let card = try state.popDeck()
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

struct EffectDraw: EffectResolverProtocol {
    let player: PlayerArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
            .draw(player: $0)
        }
    }
}
