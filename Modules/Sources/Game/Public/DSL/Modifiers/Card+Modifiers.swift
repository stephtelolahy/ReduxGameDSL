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
        self.actions = content().toDictionary()
    }
}

private extension Array where Element == CardAction {
    func toDictionary() -> [EventReq: CardEffect] {
        reduce(into: [EventReq: CardEffect]()) {
            $0[$1.eventReq] = $1.effect
        }
    }
}
