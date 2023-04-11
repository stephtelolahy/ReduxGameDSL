//
//  ArgCard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

/// Card argument
public enum ArgCard: Codable, Equatable {

    /// card identified by
    case id(String)

    /// select any player's hand or inPlay card
    case selectAny
}
