//
//  DiscardPile.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

public struct DiscardPile: Attribute {
    public let value: CardStack

    public init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardStack(content: content)
    }
}
