//
//  PlayReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let playReducer: GameReducer
= { state, action in
    guard case let .play(actor, card) = action else {
        fatalError(GameError.unexpected)
    }

    var state = state

    // discard immediately
    try state.updatePlayer(actor) { player in
        try player.hand.remove(card)
    }
    state.discard.push(card)

    // queue side effects
    guard let cardName: String = card.extractName(),
          let cardObj: Card = state.cardRef[cardName],
          let playAction: CardActionInfo = cardObj.actions.first(where: { $0.actionType == .play }) else {
        throw GameError.cardNotPlayable(card)
    }

    // verify requirements
    let ctx = PlayContext(actor: actor, card: card)
    for playReq in playAction.playReqs {
        try matchPlayReq(playReq, state, ctx)
    }

    let element = CardEffectWithContext(effect: playAction.effect, ctx: ctx)
    state.queue.append(element)

    state.completedAction = action

    return state
}
