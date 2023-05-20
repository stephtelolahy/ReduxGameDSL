//
//  Play.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

struct Play: GameReducerProtocol {
    let actor: String
    let card: String
    let target: String?

    func reduce(state: GameState) throws -> GameState {
        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              var sideEffect = cardObj.actions[.onPlay] else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx = EffectContext(actor: actor, card: card, target: target)

        if case let .requireEffect(playReqs, childEffect) = sideEffect {
            for playReq in playReqs {
                try playReq.match(state: state, ctx: ctx)
            }

            sideEffect = childEffect
        }

        // resolve target
        if case let .targetEffect(requiredTarget, childEffect) = sideEffect {
            let resolvedTarget = try requiredTarget.resolve(state: state, ctx: ctx)
            if case let .selectable(pIds) = resolvedTarget {

                if target == nil {
                    var state = state
                    let options = pIds.reduce(into: [String: GameAction]()) {
                        $0[$1] = GameAction.play(actor: actor, card: card, target: $1)
                    }
                    let childAction = GameAction.chooseOne(chooser: actor, options: options)
                    state.queue.insert(childAction, at: 0)
                    return state
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

        state.event = .play(actor: actor, card: card, target: target)

        // queue side effects
        state.queue.insert(sideEffect.withCtx(ctx), at: 0)
        return state
    }
}
