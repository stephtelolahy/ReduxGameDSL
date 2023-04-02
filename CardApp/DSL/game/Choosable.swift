//
//  Choosable.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

struct Choosable: Attribute {
    let value: CardLocation

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = CardLocation(content: content())
    }
}
