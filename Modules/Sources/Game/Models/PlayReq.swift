//
//  PlayReq.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

/// Function  defining constraints to play a card
public enum PlayReq: Codable, Equatable {

    /// The minimum number of active players is X
    case isPlayersAtLeast(Int)

    /// Actor must be damaged
    case isDamaged

    /// At least one player must be damaged
    case isAnyDamaged

    /// The maximum times per turn a card may be played is X
    case isTimesPerTurn(Int)
    
    /// When setting turn
    case onSetTurn

    /// When loosing last life point
    case onLooseLastHealth
}
