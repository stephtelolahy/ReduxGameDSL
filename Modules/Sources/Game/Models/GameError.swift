//
//  GameError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Game errors
public enum GameError: Error, Codable, Equatable {

    // MARK: - Specific error

    /// Expected a player with given identifier
    case playerNotFound(String)

    /// Expected player to be damaged
    case playerAlreadyMaxHealth(String)

    /// Expected a card with given identifier
    case cardNotFound(String)

    /// Expected card to have action
    case cardNotPlayable(String)

    /// Expected non empty deck
    case deckIsEmpty

    // MARK: - Matching error

    /// Not matching card
    case noCard(CardArg)

    /// Not matching player
    case noPlayer(PlayerArg)

    /// Not matching requirement
    case noReq(PlayReq)

    /// Expected to choose one of waited action
    case unwaitedAction

    // MARK: - Default error

    /// Any unexpected error
    case unexpected
}
