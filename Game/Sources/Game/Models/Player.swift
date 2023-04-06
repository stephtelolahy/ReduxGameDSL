//
//  Player.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

/// Player who is playing in a game
public struct Player: Codable, Equatable, Attribute {

    /// Unique identifier
    public let id: String

    /// player name
    public var name: String = ""

    /// max health
    public var maxHealth: Int = 0

    /// current health
    public var health: Int = 0

    /// Maximum allowed hand cards at the end of his turn
    public var handLimit: Int = 0

    /// Weapon range
    public var weapon: Int = 1

    /// Increment distance from others
    public var mustang: Int = 0

    /// Decrement distance to others
    public var scope: Int = 0

    /// abilities
    public var abilities: [String] = []

    /// hand cards
    public var hand: CardLocation = .init()

    /// in play cards
    public var inPlay: CardLocation = .init()
}
