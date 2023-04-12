//
//  DrawReducer.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let drawReducer: EffectReducer
= { effect, state, ctx in
    guard case let .draw(player) = effect else {
        fatalError(.unexpected)
    }

    var state = state

    // resolve player
    guard case let .id(pId) = player else {
        let resolved = try argPlayerResolver(player, state, ctx)
        switch resolved {
        case let .identified(pIds):
            let children = pIds.map {
                CardEffect.draw(player: .id($0)).withCtx(ctx)
            }
            state.queue.insert(contentsOf: children, at: 0)

        default:
            fatalError(.unexpected)
        }

        return state
    }

    // draw card
    let card = try state.popDeck()
    try state.updatePlayer(pId) { playerObj in
        playerObj.hand.add(card)
    }

    state.completedAction = .apply(effect, ctx: ctx)

    return state
}


private extension GameState {
    /// Remove top deck card
    /// reseting deck if empty
    mutating func popDeck() throws -> String {
        // swiftlint:disable:next empty_count
        if deck.count == 0,
           discard.count >= 2 {
            let cards = discard.cards
            discard = CardStack(cards: Array(cards.prefix(1)))
            deck = CardStack(cards: Array(cards.dropFirst()).shuffled())
        }

        return try deck.pop()
    }
}
