//
//  IsTimesPerTurn.swift
//  
//
//  Created by Hugues Telolahy on 17/04/2023.
//

struct IsTimesPerTurn: PlayReqMatcherProtocol {
    let maxTimes: Int

    func match(state: GameState, ctx: EffectContext) throws {
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
