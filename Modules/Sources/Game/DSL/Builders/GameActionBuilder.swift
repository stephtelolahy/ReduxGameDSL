//
//  GameActionBuilder.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

@resultBuilder
public struct GameActionsBuilder {

    public static func buildBlock(_ components: GameAction...) -> [GameAction] {
        components
    }
}

@resultBuilder
public struct GameActionBuilder {

    public static func buildBlock(_ component: GameAction) -> GameAction {
        component
    }
}
