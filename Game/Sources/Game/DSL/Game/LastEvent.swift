//
//  LastEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public struct LastEvent: Attribute {
    public let value: GameEvent

    public init(_ value: GameEvent) {
        self.value = value
    }
}
