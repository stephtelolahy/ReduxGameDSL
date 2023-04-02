//
//  Hand.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//

struct Hand: Attribute {
    let value: CardLocation

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardLocation(content: content())
    }
}
