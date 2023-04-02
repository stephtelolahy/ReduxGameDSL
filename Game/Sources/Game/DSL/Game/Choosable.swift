//
//  Choosable.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public struct Choosable: Attribute {
    public let value: CardLocation

    public init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardLocation(cards: content())
    }
}
