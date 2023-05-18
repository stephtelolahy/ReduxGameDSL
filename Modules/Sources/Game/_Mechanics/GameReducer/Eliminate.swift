//
//  Eliminate.swift
//  
//
//  Created by Hugues Telolahy on 05/05/2023.
//

struct Eliminate: GameReducerProtocol {
    let player: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.playOrder.removeAll(where: { $0 == player })
        return state
    }
}
