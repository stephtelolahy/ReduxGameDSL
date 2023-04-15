//
//  NumArg.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

/// Number argument
public enum NumArg: Codable, Equatable {

    /// Exact number
    case numExact(Int)

    /// Number of active players
    case numPlayers
}
