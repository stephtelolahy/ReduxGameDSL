//
//  LastEvent.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

struct LastEvent: Attribute {
    let value: GameEvent

    init(_ value: GameEvent) {
        self.value = value
    }
}
