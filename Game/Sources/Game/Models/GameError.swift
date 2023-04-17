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

    // MARK: - Context error

    /// Expected a targeted player
    case missingTarget

    /// Expected a card owner
    case missingCardOwner

    // MARK: - Game error

    /// Expected players count to be leat X
    case playersMustBeAtLeast(Int)

    /// Expected to get some choosable cards
    case choosableIsEmpty

    /// No player having card
    case noPlayerWithCard

    /// Expected some player damaged
    case noPlayerDamaged

    /// Expected to play a card below limit per turn
    case reachedLimitPerTurn(Int)

    /// Expected non empty deck
    case deckIsEmpty

    /// Any unexpected error
    case unexpected
}
