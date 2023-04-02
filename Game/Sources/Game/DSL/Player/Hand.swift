//
//  Hand.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//

public struct Hand: Attribute {
    public let value: CardLocation

    public init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardLocation(cards: content())
    }
}
