//
//  Player.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

/// Player who is playing in a game
struct Player: Codable, Equatable {

    /// Unique identifier
    var id: String = UUID().uuidString

    /// player name
    var name: String = ""

    /// max health
    var maxHealth: Int = 0

    /// current health
    var health: Int = 0

    /// Maximum allowed hand cards at the end of his turn
    var handLimit: Int = 0

    /// Weapon range
    var weapon: Int = 1

    /// Increment distance from others
    var mustang: Int = 0

    /// Decrement distance to others
    var scope: Int = 0

    /// abilities
    var abilities: [Card] = []

    /// hand cards
    var hand: CardLocation = .init()

    /// in play cards
    var inPlay: CardLocation = .init()
}
