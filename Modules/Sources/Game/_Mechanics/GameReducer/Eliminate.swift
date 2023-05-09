//
//  Eliminate.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct Eliminate: GameReducerProtocol {
    let player: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.playOrder.removeAll(where: { $0 == player })
        return state
    }
}

struct EffectEliminate: EffectResolverProtocol {
    let player: PlayerArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
            .eliminate($0)
        }
    }
}
