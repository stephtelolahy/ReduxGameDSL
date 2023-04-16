//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let value: Int
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.heal(value, player: .id($0)).withCtx(ctx)
            }
        }

        // update health
        state[keyPath: \GameState.players[pId]]?.health -= value

        state.completedAction = action

        return state
    }
}

private extension Player {
    mutating func gainHealth(_ value: Int) throws {
        guard health < maxHealth else {
            throw GameError.playerAlreadyMaxHealth(id)
        }

        let newHealth = min(health + value, maxHealth)
        health = newHealth
    }
}
