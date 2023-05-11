//
//  SetTurn.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct SetTurn: GameReducerProtocol {
    let player: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.turn = player
        state.playCounter = [:]
        return state
    }
}

struct EffectSetTurn: EffectResolverProtocol {
    let player: PlayerArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try player.resolve(state: state, ctx: ctx) {
            .setTurn($0)
        }
    }
}
