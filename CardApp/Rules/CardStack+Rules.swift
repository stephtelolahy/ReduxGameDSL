//
//  CardStack+Rules.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardStack {

    @discardableResult
    mutating func pop() -> Card {
        cards.removeFirst()
    }

    mutating func push(_ card: Card) {
        cards.insert(card, at: 0)
    }
}
