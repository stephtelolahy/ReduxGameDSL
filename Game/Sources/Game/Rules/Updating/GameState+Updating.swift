//
//  GameState+Updating.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

extension GameState {
    mutating func updatePlayer(_ id: String, closure: (inout Player) throws -> Void) throws {
        guard let index = players.firstIndex(where: { $0.id == id }) else {
            throw GameError.missingPlayer(id)
        }

        var player = players[index]
        try closure(&player)
        players[index] = player
    }
}
