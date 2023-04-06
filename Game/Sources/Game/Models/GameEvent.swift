//
//  GameEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Function that causes any change in the game state
public enum GameEvent: Codable, Equatable {

    /// Performing a action with a specific card
    case doAction(CardAction)

    /// Applying some card side effects
    case applyEffect(CardEffect)
}

public enum CardAction: Codable, Equatable {
    case play
    case equip
    case handicap
    case choose
}
