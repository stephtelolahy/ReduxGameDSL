//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws
}

struct PlayReqMatcher {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        try playReq.matcher().match(state: state, ctx: ctx)
    }
}

private extension PlayReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case let .isPlayersAtLeast(count):
            return IsPlayersAtLeast(count: count)

        case .isDamaged:
            return IsDamaged()

        case .isAnyDamaged:
            return IsAnyDamaged()

        case let .isTimesPerTurn(count):
            return IsTimesPerTurn(maxTimes: count)
        }
    }
}
