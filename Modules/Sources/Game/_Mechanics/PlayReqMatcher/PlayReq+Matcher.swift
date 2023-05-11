//
//  PlayReq+Matcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension PlayReq {
    func match(state: GameState, ctx: EffectContext) throws {
        let matched = try matcher().match(state: state, ctx: ctx)
        guard matched else {
            throw GameError.mismatched(self)
        }
    }
}

protocol PlayReqMatcherProtocol {
    func match(state: GameState, ctx: EffectContext) throws -> Bool
}

private extension PlayReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case let .isPlayersAtLeast(minCount): return IsPlayersAtLeast(minCount: minCount)
        case .isDamaged: return IsDamaged()
        case .isAnyDamaged: return IsAnyDamaged()
        case let .isTimesPerTurn(maxTimes): return IsTimesPerTurn(maxTimes: maxTimes)
        }
    }
}

extension PlayEvent {
    func match(state: GameState, ctx: EffectContext) throws -> Bool {
        try matcher().match(state: state, ctx: ctx)
    }
}

private extension PlayEvent {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case .onSetTurn: return OnSetTurn()
        case .onLooseLastHealth: return OnLooseLastHealth()
        }
    }
}
