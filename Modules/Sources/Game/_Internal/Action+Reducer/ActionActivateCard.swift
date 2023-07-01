//
//  ActionActivateCard.swift
//  
//
//  Created by Hugues Telolahy on 01/07/2023.
//

struct ActionActivateCard: GameReducerProtocol {
    let player: String
    let cards: [String]

    func reduce(state: GameState) throws -> GameState {
        assert(state.isOver == nil)
        assert(state.chooseOne == nil)
        assert(state.queue.isEmpty)

        var state = state
        state.active = ActiveCards(player: player, cards: cards)
        return state
    }
}
