//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal {}

extension Heal: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput {
        guard case let .heal(value, player) = effect else {
            fatalError(.unexpected)
        }

        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .event(.heal(value, player: $0))
        }
    }
}

extension Heal: EventReducerProtocol {
    func reduce(state: GameState, event: GameEvent) throws -> GameState {
        guard case let .heal(value, player) = event else {
            fatalError(.unexpected)
        }

        var state = state
        try state[keyPath: \GameState.players[player]]?.gainHealth(value)
        return state
    }
}
