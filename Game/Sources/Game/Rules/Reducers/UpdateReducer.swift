//
//  UpdateReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let updateReducer: GameReducer
= { state, _ in
    guard !state.queue.isEmpty else {
        return state
    }

    var state = state
    let effect = state.queue.remove(at: 0)
    return gameReducer(state, .apply(effect))
}
