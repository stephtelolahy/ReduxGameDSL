//
//  GroupActions.swift
//  
//
//  Created by Hugues Telolahy on 07/05/2023.
//

struct GroupActions: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .groupActions(children) = action else {
            fatalError(.unexpected)
        }

        var state = state
        state.queue.insert(contentsOf: children, at: 0)
        return state
    }
}
