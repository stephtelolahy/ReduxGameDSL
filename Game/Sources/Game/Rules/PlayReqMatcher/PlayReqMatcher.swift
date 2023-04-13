//
//  PlayReqMatcher.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

typealias PlayReqMatcher = (PlayReq, GameState, PlayContext) throws -> Void

let matchPlayReq: PlayReqMatcher
= { playReq, state, ctx in
    switch playReq {
    case let .isPlayersAtLeast(count):
        try IsPlayersAtLeast(count: count).match(state: state, ctx: ctx)

    case .isActorDamaged:
        try IsActorDamaged().match(state: state, ctx: ctx)

    case .isAnyDamaged:
        try isAnyDamaged(playReq, state, ctx)

    default:
        fatalError(.unexpected)
    }
}
