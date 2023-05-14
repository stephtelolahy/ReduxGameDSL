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
}

/// Function defining occurred event to play a card
public enum EventReq: Codable, Equatable {

    /// When playing a card
    case onPlay

    /// When setting turn
    case onSetTurn

    /// When loosing last life point
    case onLooseLastHealth
}
