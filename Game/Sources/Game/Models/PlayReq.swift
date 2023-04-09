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

    /// Actor must be damaged
    case isActorDamaged

    /// When just eliminated
    case onEliminated
}
