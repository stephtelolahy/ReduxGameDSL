//
//  NumPlayers.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

struct NumPlayers: NumArgResolverProtocol {
    func resolve(state: GameState, ctx: PlayContext) throws -> Int {
        state.playOrder.count
    }
}
