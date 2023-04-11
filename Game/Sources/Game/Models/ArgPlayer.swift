//
//  ArgPlayer.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

/// Player argument
public enum ArgPlayer: Codable, Equatable {

    /// player identified by
    case id(String)

    /// who is playing the card
    case actor

    /// all damaged players
    case damaged

    /// target player
    case target

    /// select any other player with card
    case selectAnyWithCard
}
