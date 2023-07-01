//
//  ActiveCardMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 01/07/2023.
//

import Redux
import Combine

/// Dispatching active cards
let activeCardMiddleware: Middleware<GameState, GameAction> = { state, _ in
    guard state.queue.isEmpty,
          state.isOver == nil,
          state.chooseOne == nil,
          state.event?.isActiveCard != true,
          let actor = state.turn,
          let actorObj = state.players[actor] else {
        return Empty()
            .eraseToAnyPublisher()
    }
    
    var activeCards: [String] = []
    for card in (actorObj.hand.cards + actorObj.abilities + state.abilities)
    where isCardPlayable(card, actor: actor, state: state) {
        activeCards.append(card)
    }
    
    if activeCards.isNotEmpty {
        let action = GameAction.activateCard(player: actor, cards: activeCards)
        return Just(action)
            .eraseToAnyPublisher()
    }
    
    return Empty()
        .eraseToAnyPublisher()
}

private func isCardPlayable(_ card: String, actor: String, state: GameState) -> Bool {
    let cardName = card.extractName()
    guard let cardObj = state.cardRef[cardName] else {
        return false
    }
    
    guard cardObj.actions.contains(where: { $0.eventReq == .onPlay }) else {
        return false
    }
    
    do {
        let action = GameAction.play(card, actor: actor)
        try action.validate(state: state)
        return true
    } catch {
        return false
    }
}

private extension GameAction {
    var isActiveCard: Bool {
        switch self {
        case .activateCard:
            return true
        default:
            return false
        }
    }
}
