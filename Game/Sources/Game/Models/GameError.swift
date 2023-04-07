//
//  GameError.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

/// Fatal game errors
public enum GameError: Error, Codable, Equatable {
    case missingPlayer(String)
    case missingCard(String)
}
