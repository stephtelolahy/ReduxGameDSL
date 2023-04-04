//
//  DiscardPile.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

public struct DiscardPile: Attribute {
    public let value: CardStack

    public init(@StringBuilder _ content: () -> [String]) {
        self.value = CardStack(content: content)
    }
}
