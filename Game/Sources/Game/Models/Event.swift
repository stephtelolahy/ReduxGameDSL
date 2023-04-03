//
//  Event.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Function that causes any change in the game state
public enum Event: Codable, Equatable {
    case action(PlayerAction, actor: String)
    case effect(CardEffect)
    case failure(GameError)
}

public enum PlayerAction: Codable, Equatable {

    case play(id: String)

    /// Select an option during effect resolution
    case choose(id: String)

    case endTurn
}

public enum CardEffect: Codable, Equatable {

    /// Draw top deck card
    case draw(player: String)

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: String)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: String)

    /// Discard a player's card to discard pile
    /// Actor is the card chooser
    case discard

    /// Remove player from game
    case eliminate

    /// Flip over the top card of the deck, then apply effects according to suits and values
    case luck

    /// Set turn
    case setTurn

    /// Set game over
    case setGameOver

    /// Increment attribute
    case incrementAttribute

    /// Choose one of pending actions to proceed effect resolving
    case chooseOne

    /// Cancel some queued events
    case cancel
}

public enum GameError: Error, Codable, Equatable {
    case playersMustBeAtLeast(Int)
}
