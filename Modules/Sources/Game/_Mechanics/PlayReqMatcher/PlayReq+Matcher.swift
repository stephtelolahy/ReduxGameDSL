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
        case let .isTimesPerTurn(maxTimes): return IsTimesPerTurn(maxTimes: maxTimes)
        case .isCurrentTurn: return IsCurrentTurn()
        }
    }
}

extension EventReq {
    func match(state: GameState, ctx: EffectContext) throws -> Bool {
        try matcher().match(state: state, ctx: ctx)
    }
}

private extension EventReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case .onPlay: fatalError(.unexpected)
        case .onSetTurn: return OnSetTurn()
        case .onLooseLastHealth: return OnLooseLastHealth()
        case .onEliminated: return OnEliminated()
        }
    }
}
