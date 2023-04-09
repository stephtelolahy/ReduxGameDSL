//
//  PlayReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

import Redux

let playReducer: Reducer<GameState, GameAction>
= { state, action in
    guard case let .play(actor, card) = action else {
        fatalError(GameError.unexpected)
    }

    var state = state
    do {
        // discard immediately
        try state.updatePlayer(actor) { player in
            try player.hand.remove(card)
        }
        state.discard.push(card)

        // queue side effects
        guard let cardName: String = card.split(separator: "-").first.map(String.init),
           let cardObj: Card = state.cardRef[cardName],
           let playAction: CardActionInfo = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardNotPlayable(card)
        }

        // verify requirements
        for playReq in playAction.playReqs {
            if case let .failure(error) = matchPlayReq(playReq, state) {
                throw error
            }
        }

        state.queue.append(playAction.effect)

        state.completedAction = action
    } catch {
        state.thrownError = (error as? GameError).unsafelyUnwrapped
    }

    return state
}
