//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .damage(player, value) = action else {
            fatalError(.unexpected)
        }

        var state = state
        state[keyPath: \GameState.players[player]]?.looseHealth(value)
        return state
    }
}

struct EffectDamage: EffectResolverProtocol {
    let player: PlayerArg
    let value: Int
    
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
            .damage(player: $0, value: value)
        }
    }
}
