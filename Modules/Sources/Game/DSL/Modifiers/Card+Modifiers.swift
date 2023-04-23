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

public extension GameAction {
    
    func onPlay(target: PlayerArg? = nil, @PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardAction {
        .init(actionType: .play,
              playReqs: playReqs(),
              target: target,
              effect: self)
    }
    
    func onEquip(@PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardAction {
        .init(actionType: .equip,
              playReqs: playReqs(),
              effect: self)
    }
    
    func onHandicap(target: PlayerArg, @PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardAction {
        .init(actionType: .handicap,
              playReqs: playReqs(),
              target: target,
              effect: self)
    }
    
    func onEvent(@PlayReqBuilder playReqs: () -> [PlayReq]) -> CardAction {
        .init(actionType: .triggered,
              playReqs: playReqs(),
              effect: self)
    }
}
