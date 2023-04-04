//
//  PlayReq.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

/// Function  defining constraints to play a card
public enum PlayReq: Codable, Equatable {

    /// Game is over
    case isGameOver

    /// The minimum number of active players is X
    case isPlayersAtLeast(Int)

    /// When just eliminated
    case onEliminated
}
