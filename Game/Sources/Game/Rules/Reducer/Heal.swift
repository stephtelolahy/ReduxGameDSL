//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let value: Int
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state

        // resolve player
        guard case let .id(pId) = player else {
            let resolved = try argPlayerResolver(player, state, ctx)
            switch resolved {
            case let .identified(pIds):
                let children = pIds.map {
                    CardEffect.heal(value, player: .id($0)).withCtx(ctx)
                }
                state.queue.insert(contentsOf: children, at: 0)

            default:
                fatalError(.unexpected)
            }

            return state
        }

        // update health
        try state[keyPath: \GameState.players[pId]]?.gainHealth(value)
        
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
