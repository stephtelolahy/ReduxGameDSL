//
//  ActionPlay.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct ActionPlay: GameReducerProtocol {
    let actor: String
    let card: String
    let target: String?

    func reduce(state: GameState) throws -> GameState {
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              var sideEffect = cardObj.actions[.onPlay] else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx = EffectContext(actor: actor, card: card, target: target)

        if case let .requireEffect(_, childEffect) = sideEffect {
            sideEffect = childEffect
        }

        if case let .targetEffect(requiredTarget, childEffect) = sideEffect {
            let resolvedTarget = try requiredTarget.resolve(state: state, ctx: ctx)
            if case .selectable = resolvedTarget {
                guard target != nil else {
                    fatalError("invalid play: missing target")
                }
                sideEffect = childEffect
            }
        }

        var state = state

        // discard played hand card
        let actorObj = state.player(actor)
        if actorObj.hand.contains(card) {
            try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
            state.discard.push(card)
        }

        state.playCounter[card] = (state.playCounter[card] ?? 0) + 1
        
        state.queue.insert(sideEffect.withCtx(ctx), at: 0)
        return state
    }
}