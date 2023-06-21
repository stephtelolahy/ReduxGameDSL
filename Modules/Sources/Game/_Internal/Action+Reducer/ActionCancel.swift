//
//  ActionCancel.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 22/06/2023.
//

struct ActionCancel: GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.queue.remove(at: 0)
        return state
    }
}
