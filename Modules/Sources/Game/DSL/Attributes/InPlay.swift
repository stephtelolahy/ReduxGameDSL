//
//  InPlay.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//

public struct InPlay: Attribute {
    let value: CardLocation

    public init(@StringBuilder _ content: () -> [String]) {
        self.value = CardLocation(cards: content())
    }
}