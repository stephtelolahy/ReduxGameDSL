//
//  DiscardPile.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

struct DiscardPile: Attribute {
    let value: CardStack

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardStack(content: content())
    }
}
