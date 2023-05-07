//
//  IsAnyDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct IsAnyDamaged: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        guard state.playOrder.contains(where: { state.player($0).isDamaged }) else {
            throw GameError.mismatched(playReq)
        }
    }
}