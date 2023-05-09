//
//  Eliminate.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct Eliminate: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .eliminate(player) = action else {
            fatalError(.unexpected)
        }
        
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
