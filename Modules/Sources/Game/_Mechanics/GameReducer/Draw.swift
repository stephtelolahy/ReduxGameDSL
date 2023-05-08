//
//  Draw.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Draw: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .draw(player) = action else {
            fatalError(.unexpected)
        }

        var state = state
        let card = try state.popDeck()
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

extension Draw: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .draw(player) = effect else {
            fatalError(.unexpected)
        }

        return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
            .draw(player: $0)
        }
    }
}
