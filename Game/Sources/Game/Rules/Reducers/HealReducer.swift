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
        let resolved = argPlayerResolver(player, state, ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map { CardEffect.heal(value, player: .id($0)) }
            state.queue.insert(children, at: 0)

        default:
            fatalError(GameError.unexpected)
        }

        return state
    }

    do {
        // update health
        try state.updatePlayer(pId) { playerObj in
            try playerObj.gainHealth(value)
        }
        
        state.completedAction = .apply(effect)
    } catch {
        state.thrownError = (error as? GameError).unsafelyUnwrapped
    }

    return state
}
