//
//  IsPlayersAtLeast.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct IsPlayersAtLeast: PlayReqMatcherProtocol {
    let count: Int

    func match(state: GameState, ctx: EffectContext) throws {
        if state.playOrder.count < count {
            throw GameError.playersMustBeAtLeast(count)
        }
    }
}
