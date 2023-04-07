//
//  GameState+Reducer.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

import Redux

public extension GameState {

    static let reducer: Reducer<GameState, GameAction> = { state, action in
        var state = state

        do {
            switch action {
            case let .play(actor, card):
                try state.updatePlayer(actor) { player in
                    try player.hand.remove(card)
                }
                state.discard.push(card)

            default:
                break
            }

            state.completedAction = action
        } catch {
            state.thrownError = (error as? GameError).unsafelyUnwrapped
        }

        return state
    }
}
