//
//  GroupEffects.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct GroupEffects: GameReducerProtocol {
    let effects: [GameAction]

    func reduce(state: GameState) throws -> GameState {
        var state = state
        state.queue.insert(contentsOf: effects, at: 0)
        return state
    }
}
