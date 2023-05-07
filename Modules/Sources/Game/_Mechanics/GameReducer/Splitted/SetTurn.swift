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

extension SetTurn: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .setTurn(player) = effect else {
            fatalError(.unexpected)
        }
        
        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .setTurn($0)
        }
    }
}
