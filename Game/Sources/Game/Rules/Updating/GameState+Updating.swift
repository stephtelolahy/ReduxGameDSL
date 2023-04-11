//
//  GameState+Updating.swift
//  
//
//  Created by Hugues Telolahy on 07/04/2023.
//

extension GameState {
    mutating func updatePlayer(_ id: String, closure: (inout Player) throws -> Void) throws {
        guard let index = players.firstIndex(where: { $0.id == id }) else {
            throw GameError.missingPlayer(id)
        }

        var player = players[index]
        try closure(&player)
        players[index] = player
    }

    /// Remove top deck card
    /// reseting deck if empty
    mutating func popDeck() throws -> String {
        // swiftlint:disable:next empty_count
        if deck.count == 0,
           discard.count >= 2 {
            let cards = discard.cards
            discard = CardStack(cards: Array(cards.prefix(1)))
            deck = CardStack(cards: Array(cards.dropFirst()).shuffled())
        }

        return try deck.pop()
    }
}
