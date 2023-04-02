//
//  CardLocation+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public extension CardLocation {

    init(cards: [Card] = []) {
        self.cards = cards
    }

    init(visibility: String? = nil, @CardBuilder content: () -> [Card] = { [] }) {
        self.visibility = visibility
        self.cards = content()
    }
}
