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
        if deck.count == 0 {
            guard discard.count >= 2 else {
                throw GameError.deckIsEmpty
            }

            let cards = discard.cards
            discard = CardStack(cards: Array(cards.prefix(1)))
            deck = CardStack(cards: Array(cards.dropFirst()).shuffled())
        }
        
        return deck.cards.removeFirst()
    }

    /// Getting distance between players
    func playersAt(_ range: Int, from player: String) -> [String] {
        playOrder
            .filter { $0 != player }
            .filter { distance(from: player, to: $0) <= range }
    }

    private func distance(from player: String, to other: String) -> Int {
        guard let pIndex = playOrder.firstIndex(of: player),
              let oIndex = playOrder.firstIndex(of: other),
              pIndex != oIndex else {
            return 0
        }

        let pCount = playOrder.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + pCount - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + pCount - oIndex)
        var distance = min(rightDistance, leftDistance)
        distance -= self.player(player).scope
        distance += self.player(other).mustang
        return distance
    }
}
