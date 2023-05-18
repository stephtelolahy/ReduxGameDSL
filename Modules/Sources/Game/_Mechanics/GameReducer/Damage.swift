//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    let player: String
    let value: Int

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state[keyPath: \GameState.players[player]]?.looseHealth(value)
        return state
    }
}

struct EffectDamage: EffectResolverProtocol {
    let value: Int
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard let target = ctx.target else {
            throw GameError.noPlayer(.target)
        }
        
        return [.damage(player: target, value: value)]
    }
}
