//
//  GameState+Reducer.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

public extension GameState {

    static let reducer: (GameState, GameAction) throws -> GameState = { state, action in
        var state = state

        switch action {
        case let .play(actor, card):
            try state.updatePlayer(actor) { player in
                try player.hand.remove(card)
            }
            state.discard.push(card)

        default:
            break
        }

        return state
    }
}
