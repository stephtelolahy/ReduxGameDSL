//
//  InPlay.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//

struct InPlay: Attribute {
    let value: CardLocation

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardLocation(cards: content())
    }
}
