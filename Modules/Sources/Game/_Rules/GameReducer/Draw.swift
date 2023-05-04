//
//  Draw.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Draw: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action,
              case let .draw(player) = effect else {
            fatalError(.unexpected)
        }
        
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.draw(player: .id($0)).withCtx(ctx)
            }
        }

        var state = state
        let card = try state.popDeck()
        state[keyPath: \GameState.players[pId]]?.hand.add(card)

        state.event = .draw(player: pId)

        return state
    }
}
