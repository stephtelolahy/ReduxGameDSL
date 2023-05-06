//
//  Eliminate.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct Eliminate: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
                case let .eliminate(player) = effect else {
            fatalError(.unexpected)
        }

        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.eliminate(.id($0)).withCtx(ctx)
            }
        }

        var state = state

        state.playOrder.removeAll(where: { $0 == pId })

        state.event = .eliminate(pId)

        return state
    }
}
