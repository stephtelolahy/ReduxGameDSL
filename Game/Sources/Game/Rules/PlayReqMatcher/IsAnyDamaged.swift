//
//  IsAnyDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct IsAnyDamaged: PlayReqMatcherProtocol {
    func match(state: GameState, ctx: PlayContext) throws {
        if state.playOrder.allSatisfy({ state.player($0).health >= state.player($0).maxHealth }) {
            throw GameError.noPlayerDamaged
        }
    }
}
