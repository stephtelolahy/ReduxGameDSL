//
//  DiscardReducer.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let discardReducer: EffectReducer
= { effect, state, ctx in
    guard case let .discard(player, card) = effect else {
        fatalError(.unexpected)
    }

    var state = state

    // resolve player
    guard case let .id(pId) = player else {
        let resolved = try argPlayerResolver(player, state, ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map {
                CardEffect.discard(player: .id($0), card: card).withCtx(ctx)
            }
            state.queue.insert(contentsOf: children, at: 0)

        default:
            fatalError(.unexpected)
        }

        return state
    }

    // resolve card
    guard case let .id(cId) = card else {
        let resolved = try argCardResolver(card, state, ctx, ctx.actor, pId)
        switch resolved {
        case let .identified(cIds):
            let children = cIds.map {
                CardEffect.discard(player: .id(pId), card: .id($0)).withCtx(ctx)
            }
            state.queue.insert(contentsOf: children, at: 0)

        case let .selectable(cIdOptions):
            state.chooseOne = cIdOptions.map {
                .apply(.discard(player: .id(pId), card: .id($0.id)), ctx: ctx)
            }
        }

        return state
    }

    try state.updatePlayer(pId) { playerObj in
        if playerObj.hand.contains(cId) {
            try playerObj.hand.remove(cId)
        } else if playerObj.inPlay.contains(cId) {
            try playerObj.inPlay.remove(cId)
        } else {
            throw GameError.missingCard(cId)
        }
    }

    state.discard.push(cId)

    state.completedAction = .apply(effect, ctx: ctx)

    return state
}