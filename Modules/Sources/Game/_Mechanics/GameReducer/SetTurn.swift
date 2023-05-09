//
//  SetTurn.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct SetTurn: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .setTurn(player) = action else {
            fatalError(.unexpected)
        }
        
        var state = state
        state.turn = player
        state.playCounter = [:]
        return state
    }
}

struct EffectSetTurn: EffectResolverProtocol {
    let player: PlayerArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
            .setTurn($0)
        }
    }
}
