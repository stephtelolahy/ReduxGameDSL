//
//  Card+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

public extension Card {
    
    init(_ name: String, @CardActionInfoBuilder content: () -> [CardActionInfo] = { [] }) {
        self.name = name
        self.actions = content()
    }
}

public extension CardEffect {

    func onPlay(@PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardActionInfo {
        .init(action: .play,
              effect: self,
              playReqs: playReqs())
    }

    func onEquip(@PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardActionInfo {
        .init(action: .equip,
              effect: self,
              playReqs: playReqs())
    }

    func onHandicap(@PlayReqBuilder playReqs: () -> [PlayReq] = { [] }) -> CardActionInfo {
        .init(action: .handicap,
              effect: self,
              playReqs: playReqs())
    }

    func onEvent(@PlayReqBuilder playReqs: () -> [PlayReq]) -> CardActionInfo {
        .init(action: .triggered,
              effect: self,
              playReqs: playReqs())
    }
}
