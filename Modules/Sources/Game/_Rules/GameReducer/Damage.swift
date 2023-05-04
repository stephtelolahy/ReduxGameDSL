//
//  Damage.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct Damage: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .damage(value, player) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.damage(value, player: .id($0)).withCtx(ctx)
            }
        }

        var state = state
        state[keyPath: \GameState.players[pId]]?.health -= value
        
        state.event = .damage(value, player: pId)

        return state
    }
}
