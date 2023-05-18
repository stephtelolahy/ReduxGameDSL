//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Heal: GameReducerProtocol {
    let player: String
    let value: Int

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state[keyPath: \GameState.players[player]]?.gainHealth(value)
        return state
    }
}

struct EffectHeal: EffectResolverProtocol {
    let value: Int
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard let target = ctx.target else {
            throw GameError.noPlayer(.target)
        }

        return [.heal(player: target, value: value)]
    }
}
