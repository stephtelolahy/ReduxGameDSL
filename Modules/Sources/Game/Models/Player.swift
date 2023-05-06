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

    /// Display name
    public var name: String = String()
    
    /// Card attributes
    public var attributes: [AttributeKey: Int] = [:]

    /// Abilities
    public var abilities: Set<String> = []

    /// Hand cards
    public var hand: CardLocation = .init()

    /// In play cards
    public var inPlay: CardLocation = .init()
}
