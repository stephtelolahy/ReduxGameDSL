//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    let player: PlayerArg
    let card: CardArg
    let ctx: EffectContext?

    func reduce(state: GameState) throws -> GameState {
        var state = state
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx!) {
                .discard(player: .id($0), card: card, ctx: ctx)
            }
        }

        guard case let .id(cId) = card else {
            return try CardArgResolver().resolve(arg: card, state: state, ctx: ctx!, chooser: ctx!.actor, owner: pId) {
                .discard(player: player, card: .id($0), ctx: ctx)
            }
        }

        try state[keyPath: \GameState.players[pId]]?.removeCard(cId)

        state.discard.push(cId)

        state.completedAction = .discard(player: player, card: card)

        return state
    }
}
