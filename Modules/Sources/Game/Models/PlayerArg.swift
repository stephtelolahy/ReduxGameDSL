//
//  PlayerArg.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

/// Player argument
public enum PlayerArg: Codable, Equatable {

    /// The player identified by
    case id(String)

    /// Who is playing the card
    case actor

    /// All damaged players
    case damaged

    /// Target player that was previously selected
    case target

    /// Select any other player
    case selectAny

    /// Select any other player, having card
    case selectAnyWithCard

    /// Select any reachable at range
    case selectAt(Int)

    /// Select any other player at distance of X , having card
    case selectAtRangeWithCard(Int)

    /// Select any reachable player
    case selectReachable

    /// All players
    case all

    /// Other players
    case others
}
