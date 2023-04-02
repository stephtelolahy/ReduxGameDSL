//
//  GameEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Function that causes any change in the game state
public enum GameEvent: Codable, Equatable {
    case action(PlayerAction, actor: String)
    case effect(CardEffect)
}

public enum PlayerAction: Codable, Equatable {

    case play(id: String)

    case choose(id: String)

    case endTurn
}

public enum CardEffect: Codable, Equatable {

    case draw(player: String)

    case heal(Int, player: String)
    
    case damage(Int, player: String)
}
