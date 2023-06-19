//
//  GameReducer.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//
import Redux

public struct GameReducer: ReducerProtocol {

    public init() {}

    public func reduce(state: GameState, action: GameAction) -> GameState {
        guard state.isOver == nil else {
            return state
        }

        var state = state
        state.event = nil
        state.error = nil

        do {
            state = try prepareAction(action: action, state: state)
            state = try executeAction(action: action, state: state)
            state = postExecuteAction(action: action, state: state)
            state = updateGameOver(state: state)
        } catch {
            state.error = error as? GameError
        }

        return state
    }
}

private extension GameReducer {

    func prepareAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state

        if let chooseOne = state.chooseOne {
            guard chooseOne.options.values.contains(action) else {
                throw GameError.unwaitedAction
            }
            state.chooseOne = nil
        }

        if state.queue.first == action {
            state.queue.removeFirst()
        }

        // validate play
        if case .play = action {
            _ = try action.validate(state: state)
        }
        
        // remove active
        state.active = nil

        return state
    }

    func executeAction(action: GameAction, state: GameState) throws -> GameState {
        var state = state
        state = try action.reduce(state: state)
        switch action {
        case .play,
                .resolve,
                .group:
            break

        default:
            state.event = action
        }
        return state
    }

    func postExecuteAction(action: GameAction, state: GameState) -> State {
        var state = state

        // Queue triggered effects
        var players = state.playOrder
        if case let .eliminate(justEliminated) = state.event {
            players.append(justEliminated)
        }

        var triggered: [GameAction] = []
        for actor in players {
            let actorObj = state.player(actor)
            for card in (actorObj.abilities + state.abilities) {
                let ctx: EffectContext = [.actor: actor, .card: card]
                if let effect = triggeredEffect(ctx: ctx, state: state) {
                    let sideEffect = effect.withCtx(ctx)
                    triggered.append(sideEffect)
                }
            }
        }
        state.queue.insert(contentsOf: triggered, at: 0)

        // Emit active cards
        if state.queue.isEmpty,
           state.isOver == nil,
           state.chooseOne == nil,
           let actor = state.turn,
           let actorObj = state.players[actor] {
            var activeCards: [String] = []
            for card in (actorObj.hand.cards + actorObj.abilities + state.abilities) {
                let ctx: EffectContext = [.actor: actor, .card: card]
                if isPlayable(ctx: ctx, state: state) {
                    activeCards.append(card)
                }
            }

            if activeCards.isNotEmpty {
                state.active = ActiveCards(player: actor, cards: activeCards)
            }
        }
        
        return state
    }
    
    func isPlayable(ctx: EffectContext, state: GameState) -> Bool {
        let cardName = ctx.get(.card).extractName()
        guard let cardObj = state.cardRef[cardName] else {
            return false
        }
        
        guard cardObj.actions.contains(where: { $0.eventReq == .onPlay }) else {
            return false
        }
        
        do {
            let action = GameAction.play(actor: ctx.get(.actor), card: ctx.get(.card))
            try action.validate(state: state)
            return true
        } catch {
            return false
        }
    }
    
    func triggeredEffect(ctx: EffectContext, state: GameState) -> CardEffect? {
        guard let cardObj = state.cardRef[ctx.get(.card)] else {
            return nil
        }
        
        for action in cardObj.actions {
            do {
                let eventMatched = try action.eventReq.match(state: state, ctx: ctx)
                if eventMatched {
                    let sideEffect = action.effect
                    let gameAction = GameAction.resolve(sideEffect, ctx: ctx)
                    try gameAction.validate(state: state)

                    return sideEffect
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    func updateGameOver(state: GameState) -> GameState {
        guard case .eliminate = state.event,
           let winner = state.winner() else {
               return state
        }
        
        var state = state
        state.isOver = GameOver(winner: winner)
        return state
    }
}

private extension GameAction {
    func validate(state: GameState) throws {
        var state = try reduce(state: state)
        if state.queue.isNotEmpty {
            let nextAction = state.queue.remove(at: 0)
            switch nextAction {
            case let .chooseOne(_, options):
                if let firstAction = options.first?.value {
                    try firstAction.validate(state: state)
                }

            default:
                try nextAction.validate(state: state)
            }
        }
    }
}
