//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension PlayReq {
    func match(state: GameState, ctx: EffectContext) throws {
        try matcher().match(state: state, ctx: ctx)
    }
}

protocol PlayReqMatcherProtocol {
    // TODO: return boolean
    func match(state: GameState, ctx: EffectContext) throws
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
