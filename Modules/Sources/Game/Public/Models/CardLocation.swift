//
//  CardLocation.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Card zone
public struct CardLocation: Codable, Equatable {

    /// Content
    public var cards: [String] = []

    /// Number of cards in the location
    public var count: Int { cards.count }

    /// If defined, specifies player who has access to content
    public var visibility: String?
}
