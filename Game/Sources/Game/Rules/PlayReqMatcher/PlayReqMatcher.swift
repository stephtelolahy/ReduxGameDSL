//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct PlayReqMatcher {
    func match(playReq: PlayReq, state: GameState, ctx: PlayContext) throws {
        switch playReq {
        case let .isPlayersAtLeast(count):
            try IsPlayersAtLeast(count: count).match(state: state, ctx: ctx)

        case .isActorDamaged:
            try IsActorDamaged().match(state: state, ctx: ctx)

        case .isAnyDamaged:
            try IsAnyDamaged().match(state: state, ctx: ctx)

        default:
            fatalError(.unexpected)
        }
    }
}
