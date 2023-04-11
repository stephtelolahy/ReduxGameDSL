//
//  GameError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Game errors
public enum GameError: Error, Codable, Equatable {

    /// Expected a player with given identifier
    case missingPlayer(String)

    /// Expected a card with given identifier
    case missingCard(String)

    /// Expected cardStack not empty
    case stackIsEmpty

    /// Expected players count to be leat X
    case playersMustBeAtLeast(Int)

    /// Expected player to be damaged
    case playerAlreadyMaxHealth(String)

    /// No player allowed to apply effect
    case noPlayerAllowed

    /// Expected player to have cards
    case playerHasNoCard(String)

    /// Expected player to have hand cards
    case playerHasNoHandCard(String)

    /// Expected player to have cards matching pattern
    case playerHasNoMatchingCard(String)

    /// Expected card to have onPlay effect
    case cardNotPlayable(String)

    /// Expected some player damaged
    case noPlayerDamaged

    /// Expected a target player
    case missingTarget

    case unexpected
}
