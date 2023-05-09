//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal: GameReducerProtocol {
    let player: String
    let value: Int

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state[keyPath: \GameState.players[player]]?.gainHealth(value)
        return state
    }
}

struct EffectHeal: EffectResolverProtocol {
    let player: PlayerArg
    let value: Int
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
            .heal(player: $0, value: value)
        }
    }
}
