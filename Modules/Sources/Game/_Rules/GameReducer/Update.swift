//
//  Update.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Update: GameReducerProtocol {
    func reduce(state: GameState) throws -> GameState {
        guard state.queue.isNotEmpty else {
            return state
        }

        var state = state
        let action = state.queue.remove(at: 0)
        return GameReducer().reduce(state: state, action: action)
    }
}
