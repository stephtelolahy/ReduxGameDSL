//
//  PlayReq.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

/// Function defining state constraints to play a card
public enum PlayReq: Codable, Equatable {

    /// The minimum number of active players is X
    case isPlayersAtLeast(Int)

    /// The maximum times per turn a card may be played is X
    case isTimesPerTurn(Int)

    /// Is actor the current turn
    case isCurrentTurn
}

/// Function defining occurred event to play a card
public enum EventReq: Codable, Equatable {

    /// After playing a card
    case onPlay

    /// After setting turn
    case onSetTurn

    /// After loosing last life point
    case onLooseLastHealth

    /// After being eliminated
    case onEliminated
}
