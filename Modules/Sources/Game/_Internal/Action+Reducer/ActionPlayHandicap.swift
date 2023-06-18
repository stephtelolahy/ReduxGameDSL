//
//  ActionPlayHandicap.swift
//  
//
//  Created by Hugues Telolahy on 11/06/2023.
//

struct ActionPlayHandicap: GameReducerProtocol {
    let actor: String
    let card: String
    let target: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        let actorObj = state.player(actor)
        guard actorObj.hand.contains(card) else {
            fatalError("invalid handicap: missing card")
        }

        try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
        state[keyPath: \GameState.players[target]]?.inPlay.add(card)

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1
        return state
    }
}
