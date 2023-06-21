//
//  OnForceDiscardHandNamed.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 21/06/2023.
//

struct OnForceDiscardHandNamed: EventReqMatcherProtocol {
    let cardName: String
    
    func match(state: GameState, ctx: EffectContext) -> Bool {
        false
    }
}
