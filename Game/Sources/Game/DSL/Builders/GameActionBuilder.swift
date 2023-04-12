//
//  GameActionBuilder.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

@resultBuilder
public struct GameActionBuilder {

    public static func buildBlock(_ components: GameAction...) -> [GameAction] {
        components
    }

    public static func buildExpression(_ action: GameAction) -> GameAction {
        action
    }
}
