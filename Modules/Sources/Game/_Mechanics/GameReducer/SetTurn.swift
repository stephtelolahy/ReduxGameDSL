//
//  SetTurn.swift
//  
//
//  Created by Hugues Telolahy on 01/05/2023.
//

struct SetTurn: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .setTurn(player) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.setTurn(.id($0)).withCtx(ctx)
            }
        }

        var state = state
        state.turn = pId
        state.playCounter = [:]
        state.event = .setTurn(pId)

        return state
    }
}
