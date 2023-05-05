//
//  IsTimesPerTurn.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct IsTimesPerTurn: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        guard case let .isTimesPerTurn(maxTimes) = playReq else {
            fatalError(.unexpected)
        }
        
        // No limit
        guard maxTimes > 0 else {
            return
        }

        let cardName = ctx.card.extractName()
        let playedTimes = state.counters[cardName] ?? 0
        guard playedTimes < maxTimes else {
            throw GameError.reachedLimitPerTurn(maxTimes)
        }
    }
}
