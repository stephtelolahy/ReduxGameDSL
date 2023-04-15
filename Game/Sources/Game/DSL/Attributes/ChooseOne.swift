//
//  ChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

public struct ChooseOne: Attribute {
    let value: [String: GameAction]

    public init(_ content: () -> [String: GameAction]) {
        self.value = content()
    }
}
