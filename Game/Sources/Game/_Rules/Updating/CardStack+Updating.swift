//
//  CardStack+Updating.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardStack {

    @discardableResult
    mutating func pop() throws -> String {
        guard cards.isNotEmpty else {
            throw GameError.stackIsEmpty
        }

        return cards.removeFirst()
    }

    mutating func push(_ card: String) {
        cards.insert(card, at: 0)
    }
}
