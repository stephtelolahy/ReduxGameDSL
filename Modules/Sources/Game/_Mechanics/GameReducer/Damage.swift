//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage {}

extension Damage: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .damage(value, player) = effect else {
            fatalError(.unexpected)
        }

        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .event(.damage(value, player: $0))
        }
    }
}

extension Damage: EventReducerProtocol {
    func reduce(state: GameState, event: GameEvent) throws -> GameState {
        guard case let .damage(value, player) = event else {
            fatalError(.unexpected)
        }

        var state = state
        state[keyPath: \GameState.players[player]]?.looseHealth(value)
        return state
    }
}
