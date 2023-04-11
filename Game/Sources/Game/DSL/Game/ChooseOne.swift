//
//  ChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

public struct ChooseOne: Attribute {
    let value: [GameAction]

    public init(@GameActionBuilder _ content: () -> [GameAction]) {
        self.value = content()
    }
}
