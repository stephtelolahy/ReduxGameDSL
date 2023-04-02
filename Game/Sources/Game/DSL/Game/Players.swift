//
//  Players.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

public struct Players: Attribute {
    public let value: [Player]

    public init(@PlayerBuilder _ content: () -> [Player]) {
        self.value = content()
    }
}
