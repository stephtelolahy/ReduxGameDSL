//
//  ActionPlay.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

struct ActionPlay: GameReducerProtocol {
    let actor: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        // verify action
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              var sideEffect = cardObj.actions[.onPlay] else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx: EffectContext = [.actor: actor, .card: card]

        // verify requirements
        if case let .requireEffect(playReqs, childEffect) = sideEffect {
            for playReq in playReqs {
                try playReq.match(state: state, ctx: ctx)
            }

            sideEffect = childEffect
        }

        // resolve target
        if case let .targetEffect(requiredTarget, _) = sideEffect {
            let resolvedTarget = try requiredTarget.resolve(state: state, ctx: ctx)
            if case let .selectable(pIds) = resolvedTarget {
                var state = state
                let options = pIds.reduce(into: [String: GameAction]()) {
                    $0[$1] = .playImmediate(actor: actor, card: card, target: $1)
                }
                let childAction = GameAction.chooseOne(chooser: actor, options: options)
                state.queue.insert(childAction, at: 0)
                return state
            }
        }

        let action: GameAction
        let actorObj = state.player(actor)
        if actorObj.hand.contains(card) {
            action = .playImmediate(actor: actor, card: card)
        } else {
            action = .playAbility(actor: actor, card: card)
        }

        // queue play action
        var state = state
        state.queue.insert(action, at: 0)
        return state
    }
}
