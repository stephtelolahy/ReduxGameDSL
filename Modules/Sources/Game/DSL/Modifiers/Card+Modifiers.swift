//
//  Card+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

public extension Card {
    
    init(_ name: String, @CardActionBuilder content: () -> [CardAction] = { [] }) {
        self.name = name
        self.actions = content()
    }
}

public extension CardEffect {
    func triggered(_ eventReq: EventReq) -> CardAction {
        .init(eventReq: eventReq, effect: self)
    }
}

public extension CardAction {
    @available(*, deprecated, message: "")
    func target(_ target: PlayerArg) -> Self {
        .init(eventReq: eventReq, target: target, effect: effect)
    }
}
