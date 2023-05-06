//
//  GameState+Updating.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

extension GameState {
    /// Remove top deck card by reseting deck if empty
    mutating func popDeck() throws -> String {
        if deck.cards.isEmpty {
            guard discard.count >= 2 else {
                throw GameError.deckIsEmpty
            }

            let cards = discard.cards
            discard = CardStack(cards: Array(cards.prefix(1)))
            deck = CardStack(cards: Array(cards.dropFirst()).shuffled())
        }

        return deck.pop()
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

    mutating func setChooseOne(chooser: String, options: [String: GameAction]) {
        chooseOne = ChooseOne(chooser: chooser, options: options)
        event = .chooseOne(chooser: chooser, options: Set(options.keys))
    }

    func hasWinner() -> String? {
        if playOrder.count == 1 {
            return playOrder[0]
        }

        return nil
    }
}
