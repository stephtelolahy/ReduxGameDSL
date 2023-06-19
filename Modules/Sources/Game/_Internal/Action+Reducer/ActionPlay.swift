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
              let playAction = cardObj.actions.first(where: { $0.eventReq == .onPlay }) else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx: EffectContext = [.actor: actor, .card: card]

        // verify requirements
        let sideEffect = playAction.effect
        for playReq in playAction.playReqs {
            try playReq.match(state: state, ctx: ctx)
        }

        // resolve target
        if case let .target(requiredTarget, _) = sideEffect {
            let resolvedTarget = try requiredTarget.resolve(state: state, ctx: ctx)
            if case let .selectable(pIds) = resolvedTarget {
                var state = state
                let options = pIds.reduce(into: [String: GameAction]()) {
                    let action: GameAction
                    switch cardObj.type {
                    case .immediate:
                        action = .playImmediate(actor: actor, card: card, target: $1)
                    case .handicap:
                        action = .playHandicap(actor: actor, card: card, target: $1)
                    default:
                        fatalError("unexpected")
                    }
                    
                    $0[$1] = action
                }
                let childAction = GameAction.chooseOne(chooser: actor, options: options)
                state.queue.insert(childAction, at: 0)
                return state
            }
        }

        let action: GameAction
        switch cardObj.type {
        case .equipment:
            action = .playEquipment(actor: actor, card: card)
        case .handicap:
            fatalError("unexpected")
        case .immediate:
            let actorObj = state.player(actor)
            if actorObj.hand.contains(card) {
                action = .playImmediate(actor: actor, card: card)
            } else {
                action = .playAbility(actor: actor, card: card)
            }
        }
        
        // queue play action
        var state = state
        state.queue.insert(action, at: 0)
        return state
    }
}
