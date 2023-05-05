//
//  Trigger.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 04/05/2023.
//

struct Trigger: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .trigger(actor, card) = action else {
            fatalError(.unexpected)
        }
        
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
