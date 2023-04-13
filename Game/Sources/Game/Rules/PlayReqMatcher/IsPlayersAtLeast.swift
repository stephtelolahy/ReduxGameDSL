//
//  IsPlayersAtLeast.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct IsPlayersAtLeast: PlayReqMatcherProtocol {
    let count: Int

    func match(state: GameState, ctx: PlayContext) throws {
        if state.players.count < count {
            throw GameError.playersMustBeAtLeast(count)
        }
    }
}
