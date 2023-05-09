//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws
}

extension PlayReq {
    func match(state: GameState, ctx: EffectContext) throws {
        try matcher().match(state: state, ctx: ctx)
    }
}

private extension PlayReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case let .isPlayersAtLeast(minCount): return IsPlayersAtLeast(minCount: minCount)
        case .isDamaged: return IsDamaged()
        case .isAnyDamaged: return IsAnyDamaged()
        case let .isTimesPerTurn(maxTimes): return IsTimesPerTurn(maxTimes: maxTimes)
        case .onSetTurn: return OnSetTurn()
        case .onLooseLastHealth: return OnLooseLastHealth()
        }
    }
}
