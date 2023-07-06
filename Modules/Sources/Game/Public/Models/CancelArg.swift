//
//  CancelArg.swift
//  
//
//  Created by Hugues Telolahy on 02/07/2023.
//

/// Cancel action argument
public enum CancelArg: String, Codable, Equatable {

    /// Next queued action
    case next

    /// startTurn effect
    // TODO: cancel effect where player card is
    case startTurn
}
