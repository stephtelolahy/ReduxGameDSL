//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

protocol PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws
}

struct PlayReqMatcher: PlayReqMatcherProtocol {
    func match(playReq: PlayReq, state: GameState, ctx: EffectContext) throws {
        try playReq.matcher().match(playReq: playReq, state: state, ctx: ctx)
    }
}

private extension PlayReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case .isPlayersAtLeast: return IsPlayersAtLeast()

        case .isDamaged: return IsDamaged()

        case .isAnyDamaged: return IsAnyDamaged()

        case .isTimesPerTurn: return IsTimesPerTurn()
            
        case .onSetTurn: return OnSetTurn()
        }
    }
}
