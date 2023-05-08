//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .heal(player, value) = action else {
            fatalError(.unexpected)
        }

        var state = state
        try state[keyPath: \GameState.players[player]]?.gainHealth(value)
        return state
    }
}

extension Heal: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .heal(value, player) = effect else {
            fatalError(.unexpected)
        }

        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .heal(player: $0, value: value)
        }
    }
}
