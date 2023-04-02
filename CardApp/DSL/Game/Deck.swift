//
//  Deck.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

struct Deck: Attribute {
    let value: CardStack

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardStack(cards: content())
    }
}
