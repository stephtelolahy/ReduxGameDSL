//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal: GameReducerProtocol {
    let player: PlayerArg
    let value: Int
    let ctx: EffectContext?
    
    func reduce(state: GameState) throws -> GameState {
        var state = state
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx!) {
                .heal(value, player: .id($0), ctx: ctx)
            }
        }
        
        // update health
        try state[keyPath: \GameState.players[pId]]?.gainHealth(value)
        
        state.completedAction = .heal(value, player: player)
        
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
