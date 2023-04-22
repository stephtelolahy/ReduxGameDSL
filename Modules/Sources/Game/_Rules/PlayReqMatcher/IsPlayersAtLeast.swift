//
//  IsPlayersAtLeast.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct IsPlayersAtLeast: PlayReqMatcherProtocol {
    let minCount: Int

    func match(state: GameState, ctx: EffectContext) throws {
        if state.playOrder.count < minCount {
            throw GameError.playersMustBeAtLeast(minCount)
        }
    }
}
