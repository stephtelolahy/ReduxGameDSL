//
//  Players.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

struct Players: Attribute {
    let value: [Player]

    init(@PlayerBuilder _ content: () -> [Player]) {
        self.value = content()
    }
}
