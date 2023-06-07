//
//  EventReq+Matcher.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 01/06/2023.
//

extension EventReq {
    func match(state: GameState, ctx: [ContextKey: String]) throws -> Bool {
        matcher().match(state: state, ctx: ctx)
    }
}

protocol EventReqMatcherProtocol {
    func match(state: GameState, ctx: [ContextKey: String]) -> Bool
}

private extension EventReq {
    func matcher() -> EventReqMatcherProtocol {
        switch self {
        case .onSetTurn: return OnSetTurn()
        case .onLooseLastHealth: return OnLooseLastHealth()
        case .onEliminated: return OnEliminated()
        default: return EventReqNeverMatch()
        }
    }
}

private struct EventReqNeverMatch: EventReqMatcherProtocol {
    func match(state: GameState, ctx: [ContextKey: String]) -> Bool {
        false
    }
}
