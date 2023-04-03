//
//  Event.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Function that causes any change in the game state
public enum Event: Codable, Equatable {

    /// Performing a action with a specific card
    case action(CardActionType, card: String, actor: String)

    /// Choosing between some options
    case choose(id: String, actor: String)

    /// Applying some card side effects
    case effect(CardEffect)

    /// Receiving some error
    case failure(GameError)
}

public enum GameError: Error, Codable, Equatable {
    case playersMustBeAtLeast(Int)
}
