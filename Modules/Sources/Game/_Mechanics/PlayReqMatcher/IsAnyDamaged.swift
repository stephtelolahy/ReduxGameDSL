//
//  IsAnyDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct IsAnyDamaged: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws -> Bool {
        state.playOrder.contains(where: { state.player($0).isDamaged })
    }
}
