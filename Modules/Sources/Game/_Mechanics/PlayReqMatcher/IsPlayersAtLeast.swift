//
//  IsPlayersAtLeast.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct IsPlayersAtLeast: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        guard case let .isPlayersAtLeast(minCount) = playReq else {
            fatalError(.unexpected)
        }

        if state.playOrder.count < minCount {
            throw GameError.mismatched(playReq)
        }
    }
}
