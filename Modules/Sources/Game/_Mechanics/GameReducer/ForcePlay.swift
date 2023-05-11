//
//  ForcePlay.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 04/05/2023.
//

struct ForcePlay: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        guard state.players[actor] != nil else {
            throw GameError.playerNotFound(actor)
        }
        
        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.isImmediate }) else {
            throw GameError.cardNotPlayable(card)
        }

        // queue side effects
        let ctx = EffectContext(actor: actor, card: card)
        var state = state
        state.queue.append(action.effect.withCtx(ctx))
        return state
    }
}
