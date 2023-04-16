//
//  GameError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Game errors
public enum GameError: Error, Codable, Equatable {

    // MARK: - Player error

    /// Expected a player with given identifier
    case playerNotFound(String)

    /// Expected player to be damaged
    case playerAlreadyMaxHealth(String)

    /// Expected player to have cards
    case playerHasNoCard(String)

    // MARK: - Card error

    /// Expected a card with given identifier
    case cardNotFound(String)

    /// Expected card to have onPlay effect
    case cardIsNotPlayable(String)

    // MARK: - Game error

    /// Expected players count to be leat X
    case playersMustBeAtLeast(Int)

    /// Expected to get some choosable cards
    case choosableIsEmpty

    /// No player having card
    case noPlayerWithCard

    /// Expected some player damaged
    case noPlayerDamaged

    /// Expected a target player in effect context
    case missingTarget

    /// Expected to play below limit per turn
    case reachedBangLimitPerTurn

    /// Expected non empty deck
    case deckIsEmpty

    /// Any unexpected error
    case unexpected
}
