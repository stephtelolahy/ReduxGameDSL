//
//  Trigger.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 04/05/2023.
//

struct Trigger: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        // verify play action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.actionType == .play }) else {
            throw GameError.cardIsNotPlayable(card)
        }
        
        // queue side effects
        let ctx = EffectContext(actor: actor, card: card)
        var state = state
        state.queue.append(action.effect.withCtx(ctx))

        state.event = .trigger(actor: actor, card: card)

        return state
    }
}
