//
//  ForcePlay.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 04/05/2023.
//

struct ForcePlay: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .forcePlay(actor, card) = action else {
            fatalError(.unexpected)
        }

        guard let actorObj = state.players[actor] else {
            throw GameError.playerNotFound(actor)
        }
        
        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let action = cardObj.actions.first(where: { $0.actionType == .triggered }) else {
            throw GameError.cardNotPlayable(card)
        }
        
        // queue side effects
        let ctx = EffectContext(actor: actor, card: card)
        var state = state
        state.queue.append(action.effect.withCtx(ctx))

        state.event = .forcePlay(actor: actor, card: card)

        return state
    }
}
