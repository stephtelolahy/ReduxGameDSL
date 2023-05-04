//
//  Heal.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

struct Heal: ThrowableReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .heal(value, player) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.heal(value, player: .id($0)).withCtx(ctx)
            }
        }
        
        var state = state
        try state[keyPath: \GameState.players[pId]]?.gainHealth(value)
        
        state.event = .heal(value, player: pId)
        
        return state
    }
}
