//
//  UpdateReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

struct UpdateReducer: ThrowableReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard !state.queue.isEmpty else {
            return state
        }

        var state = state
        let action = state.queue.remove(at: 0)
        return GameReducer().reduce(state: state, action: action)
    }
}
