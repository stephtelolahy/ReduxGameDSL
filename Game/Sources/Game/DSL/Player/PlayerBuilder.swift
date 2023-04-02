//
//  PlayerBuilder.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

@resultBuilder
public struct PlayerBuilder {

    public static func buildBlock(_ components: Player...) -> [Player] {
        components
    }

    public static func buildExpression(_ player: Player) -> Player {
        player
    }

    public static func buildExpression(_ id: String) -> Player {
        Player(id: id)
    }
}
