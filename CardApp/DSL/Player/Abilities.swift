//
//  Abilities.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//

struct Abilities: Attribute {
    let value: [Card]

    init(@CardBuilder _ content: () -> [Card]) {
        self.value = content()
    }
}
