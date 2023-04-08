//
//  GameError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Game errors
public enum GameError: Error, Codable, Equatable {
    case missingPlayer(String)
    case missingCard(String)
    case stackIsEmpty
}
