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

public func onPlay(
    target: PlayerArg? = nil,
    @CardEffectBuilder content: () -> CardEffect,
    @PlayReqBuilder require: () -> [PlayReq] = { [] }
) -> CardAction {
    .init(actionType: .play,
          target: target,
          playReqs: require(),
          effect: content())
}

public func onSpell(
    target: PlayerArg? = nil,
    @CardEffectBuilder content: () -> CardEffect,
    @PlayReqBuilder require: () -> [PlayReq] = { [] }
) -> CardAction {
    .init(actionType: .spell,
          target: target,
          playReqs: require(),
          effect: content())
}

public func onTriggered(
    target: PlayerArg? = nil,
    @CardEffectBuilder content: () -> CardEffect,
    @PlayReqBuilder require: () -> [PlayReq] = { [] }
) -> CardAction {
    .init(actionType: .triggered,
          target: target,
          playReqs: require(),
          effect: content())
}
