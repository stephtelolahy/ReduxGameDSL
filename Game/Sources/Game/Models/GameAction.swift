//
//  GameAction.swift
//  
//
//  Created by Hugues Telolahy on 06/04/2023.
//

/// Function that causes any change in the game state
public enum GameAction: Codable, Equatable {

    /// play a hand card
    case play(actor: String, card: String)

    /// equip a hand card
    case equip

    /// play handicap card
    case handicap

    /// choose an option
    case choose

    /// Applying some card side effects
    case apply(CardEffect)

    /// Process queued event
    case update
}
