//
//  GameAction+Validate.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 13/05/2023.
//

extension GameAction {
    func validate(state: GameState) throws {
        switch self {
        case let .play(actor, card, target):
            try validatePlay(actor: actor,
                             card: card,
                             target: target,
                             state: state)
            
        case let .resolve(effect, ctx: ctx):
            try validateEffect(effect: effect, ctx: ctx, state: state)

        case let .chooseOne(chooser, options):
            try validateChooseOne(chooser: chooser, options: options, state: state)
            
        default:
            try validateAny(action: self, state: state)
        }
    }
}

private extension GameAction {

    func validatePlay(actor: String, card: String, target: String?, state: GameState) throws {
        let cardName = card.extractName()
        guard let cardObj = state.cardRef[cardName],
              let cardAction = cardObj.actions.first(where: { $0.eventReq == .onPlay }) else {
            throw GameError.cardNotPlayable(card)
        }

        let ctx = EffectContext(actor: actor, card: card, target: target)

        // resolve target
        if let requiredTarget = cardAction.target,
           target == nil {
            let resolvedTarget = try requiredTarget.resolve(state: state, ctx: ctx)
            guard case let .selectable(pIds) = resolvedTarget else {
                fatalError(.unexpected)
            }

            let firstAction = GameAction.play(actor: actor, card: card, target: pIds[0])
            try firstAction.validate(state: state)
            return
        }

        var state = state

        // discard played hand card
        let actorObj = state.player(actor)
        if actorObj.hand.contains(card) {
            try state[keyPath: \GameState.players[actor]]?.hand.remove(card)
            state.discard.push(card)
        }


        let sideEffect = cardAction.effect.withCtx(ctx)

        try sideEffect.validate(state: state)
    }
    
    func validateEffect(effect: CardEffect, ctx: EffectContext, state: GameState) throws {
        let children = try effect.resolve(state: state, ctx: ctx)
        guard let firstAction = children.first else {
            // Empty effect
            return
        }

        try firstAction.validate(state: state)
    }

    func validateChooseOne(chooser: String, options: [String: GameAction], state: GameState) throws {
        for (_, action) in options {
            try action.validate(state: state)
        }
    }
    
    func validateAny(action: GameAction, state: GameState) throws {
        _ = try action.reduce(state: state)
    }
}
