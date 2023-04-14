//
//  Draw.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Draw: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state

        // resolve player
        guard case let .id(pId) = player else {
            let resolved = try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx)
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

        state[keyPath: \GameState.players[pId]]?.hand.add(card)

        state.completedAction = action

        return state
    }
}

private extension GameState {
    /// Remove top deck card by reseting deck if empty
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
