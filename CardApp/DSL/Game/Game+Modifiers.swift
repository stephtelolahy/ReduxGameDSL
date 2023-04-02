//
//  Game+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension Game {

    init(@AttributeBuilder components: () -> [any Attribute] = { [] }) {
        for attr in components() {
            if let players = attr as? Players {
                self.players = players.value
            } else if let deck = attr as? Deck {
                self.deck = deck.value
            } else if let discard = attr as? DiscardPile {
                self.discard = discard.value
            } else if let choosable = attr as? Choosable {
                self.choosable = choosable.value
            } //else if let lastEvent = attr as? LastEvent {
//                _event = lastEvent.value
//            }
        }
    }

    func isOver(_ value: Bool) -> Self {
        copy { $0.isOver = value }
    }

    func turn(_ value: String) -> Self {
        copy { $0.turn = value }
    }
}

private extension Game {
    func copy(closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
