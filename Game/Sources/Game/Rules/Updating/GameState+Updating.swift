//
//  GameState+Updating.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

extension GameState {
    /// Remove top deck card by reseting deck if empty
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
