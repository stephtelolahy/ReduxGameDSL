//
//  GameEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

enum GameEvent: Codable, Equatable {
    case action(PlayerAction, actor: String)
    case effect(CardEffect)
}

enum PlayerAction: Codable, Equatable {
    case playCard(id: String)
    case choose(id: String)
    case endTurn
}

enum CardEffect: Codable, Equatable {
    case draw(player: String)
    case heal(Int, player: String)
    case damage(Int, player: String)
}
