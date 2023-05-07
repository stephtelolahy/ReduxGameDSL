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

extension Eliminate: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .eliminate(player) = effect else {
            fatalError(.unexpected)
        }
        
        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .eliminate($0)
        }
    }
}
