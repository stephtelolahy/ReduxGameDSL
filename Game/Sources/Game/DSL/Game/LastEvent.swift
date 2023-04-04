//
//  LastEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public struct LastEvent: Attribute {
    public let value: Event

    public init(_ value: Event) {
        self.value = value
    }
}
