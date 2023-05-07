//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .damage(value, player) = action else {
            fatalError(.unexpected)
        }

        var state = state
        state[keyPath: \GameState.players[player]]?.looseHealth(value)
        return state
    }
}

extension Damage: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .damage(value, player) = effect else {
            fatalError(.unexpected)
        }

        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .damage(value, player: $0)
        }
    }
}
