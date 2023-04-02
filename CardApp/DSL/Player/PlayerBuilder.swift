//
//  PlayerBuilder.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

@resultBuilder
struct PlayerBuilder {

    static func buildBlock(_ components: Player...) -> [Player] {
        components
    }

    static func buildExpression(_ player: Player) -> Player {
        player
    }

    static func buildExpression(_ id: String) -> Player {
        Player(id: id)
    }
}
