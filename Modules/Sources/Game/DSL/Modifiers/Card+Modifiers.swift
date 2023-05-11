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
    func triggered(on actionType: CardActionType, target: PlayerArg? = nil) -> CardAction {
        .init(actionType: actionType, target: target, playReqs: [], effect: self)
    }
}

public extension CardAction {
    func require(@PlayReqBuilder playReqs: () -> [PlayReq]) -> Self {
        .init(actionType: actionType, target: target, playReqs: playReqs(), effect: effect)
    }
}
