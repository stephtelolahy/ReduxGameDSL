//
//  Player.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

/// Player who is playing in a game
public struct Player: Identifiable, Codable, Equatable {

    /// Unique identifier
    public let id: String

    /// player name
    public var name: String = String()

    /// max health
    public var maxHealth: Int = 0

    /// current health
    public var health: Int = 0

    /// override maximum allowed hand cards at the end of his turn
    /// by default health is maximum allowed hand cards
    public var handLimit: Int?

    /// Weapon range
    public var weapon: Int = 1

    /// Increment distance from others
    public var mustang: Int = 0

    /// Decrement distance to others
    public var scope: Int = 0

    /// Card attributes
    public var attributes: [AttributeKey: Int] = [:]

    /// Abilities
    public var abilities: [String] = []

    /// Hand cards
    public var hand: CardLocation = .init()

    /// In play cards
    public var inPlay: CardLocation = .init()
}
