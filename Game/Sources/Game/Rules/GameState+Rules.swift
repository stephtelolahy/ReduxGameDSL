//
//  GameState+Rules.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

extension GameState {
    
    mutating func updatePlayer(_ id: String, closure: (inout Player) -> Void) {
        guard let index = players.firstIndex(where: { $0.id == id }) else {
            fatalError(InternalError.missingPlayer(id))
        }

        var player = players[index]
        closure(&player)
        players[index] = player
    }
}
