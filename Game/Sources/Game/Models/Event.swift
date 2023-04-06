//
//  Event.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Function that causes any change in the game state
public enum Event: Codable, Equatable {

    /// Performing a action with a specific card
    case doAction(CardAction)

    /// Applying some card side effects
    case applyEffect(CardEffect)
}

public enum CardAction: Codable, Equatable {
    case play
    case equip
    case handicap
    case choose(ChooseOption)
}

public struct ChooseOption: Codable, Equatable {
    let label: String
    let actor: String
}

/// Function defining card side effects
public enum CardEffect: Codable, Equatable {

    case trigger

    /// Draw top deck card
    case draw(player: ArgPlayer)

    /// Restore player's health, limited to maxHealth
    case heal(Int, player: ArgPlayer)

    /// Deals damage to a player, attempting to reduce its Health by the stated amount
    case damage(Int, player: ArgPlayer)

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

    /// Do nothing
    case dummy
}
