//
//  ReplayEffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let replayEffectReducer: EffectReducer
= { effect, state, ctx in
    guard case let .replayEffect(times, childEffect) = effect else {
        fatalError(.unexpected)
    }

    guard times > 0 else {
        return state
    }

    let children = (0..<times).map { _ in
        childEffect.withCtx(ctx)
    }

    var state = state
    state.queue.insert(contentsOf: children, at: 0)
    return state
}
