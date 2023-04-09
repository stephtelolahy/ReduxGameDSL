//
//  HealReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let healReducer: EffectReducer
= { state, effect, ctx in
    guard case let .heal(value, player) = effect else {
        fatalError(GameError.unexpected)
    }

    var state = state
    guard case let .id(pId) = player else {
        // resolve player
        let resolved = try argPlayerResolver(player, state, ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map {
                CardEffectWithContext(effect: .heal(value, player: .id($0)),
                                      ctx: ctx)
            }
            state.queue.insert(contentsOf: children, at: 0)

        case .selectable:
            fatalError(GameError.unexpected)
        }

        return state
    }

    // update health
    try state.updatePlayer(pId) { playerObj in
        try playerObj.gainHealth(value)
    }

    state.completedAction = .apply(effect, ctx: ctx)

    return state
}
