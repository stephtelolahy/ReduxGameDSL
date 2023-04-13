//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct PlayReqMatcher {
    func match(playReq: PlayReq, state: GameState, ctx: PlayContext) throws {
        try playReq.matcher().match(state: state, ctx: ctx)
    }
}

private extension PlayReq {
    func matcher() -> PlayReqMatcherProtocol {
        switch self {
        case let .isPlayersAtLeast(count):
            return IsPlayersAtLeast(count: count)

        case .isActorDamaged:
            return IsActorDamaged()

        case .isAnyDamaged:
            return IsAnyDamaged()

        default:
            fatalError(.unexpected)
        }
    }
}
