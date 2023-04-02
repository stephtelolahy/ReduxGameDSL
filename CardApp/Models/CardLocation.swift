//
//  CardLocation.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Card zone
struct CardLocation: Codable, Equatable {

    /// Number of cards in the location
    var count: Int = 0

    /// If defined, specifies player who has access to content
    var visibility: String?

    /// Content
    var content: [Card] = []
}
