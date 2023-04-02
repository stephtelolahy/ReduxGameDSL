//
//  Abilities.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//

public struct Abilities: Attribute {
    public let value: [Card]

    public init(@CardBuilder _ content: () -> [Card]) {
        self.value = content()
    }
}
