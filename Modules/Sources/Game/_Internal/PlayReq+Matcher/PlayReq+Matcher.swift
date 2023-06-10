//
//  PlayReq+Matcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension PlayReq {
    func match(state: GameState, ctx: PlayContext) throws {
        let matched = matcher().match(state: state, ctx: ctx)
        guard matched else {
            throw GameError.noReq(self)
        }
    }
}

protocol PlayReqMatcherProtocol {
    func match(state: GameState, ctx: PlayContext) -> Bool
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
