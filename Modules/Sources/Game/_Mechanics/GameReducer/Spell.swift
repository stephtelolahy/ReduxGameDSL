//
//  Spell.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

struct Spell: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              var sideEffect = cardObj.actions[.onPlay] else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx = EffectContext(actor: actor, card: card)

        if case let .requireEffect(_, childEffect) = sideEffect {
            sideEffect = childEffect
        }

        var state = state

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1
        
        state.queue.insert(sideEffect.withCtx(ctx), at: 0)
        return state
    }
}
