//
//  Reveal.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct Reveal: GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState {
        var state = state
        if state.choosable == nil {
            state.choosable = .init()
        }
        let card = try state.popDeck()
        state.choosable?.add(card)

        state.event = .success(.reveal)

        return state
    }
}
