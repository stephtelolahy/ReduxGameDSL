//
//  ActionEquip.swift
//  
//
//  Created by Hugues Telolahy on 10/06/2023.
//

struct ActionEquip: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        let actorObj = state.player(actor)
        guard actorObj.hand.contains(card) else {
            fatalError("invalid equip: missing card")
        }

        try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
        state[keyPath: \GameState.players[actor]]?.inPlay.add(card)

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1
        return state
    }
}