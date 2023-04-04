//
//  CardLocation+Rules.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Game

extension CardLocation {

    func search(byId id: String) -> Card? {
        cards.first { $0.id == id }
    }

    mutating func add(_ card: Card) {
        cards.append(card)
    }

    mutating func remove(byId id: String) -> Card {
        guard let index = cards.firstIndex(where: { $0.id == id }) else {
            fatalError("Card \(id) not found")
        }

        return cards.remove(at: index)
    }
}
