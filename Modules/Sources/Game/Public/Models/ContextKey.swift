//
//  ContextKey.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Context data associated to an effect
public enum ContextKey: String, Equatable, Codable {
    
    /// the actor playing card
    case actor
    
    /// played card
    case card
    
    /// selected target
    case target
    
    /// selected target
    case cardSelected
}
