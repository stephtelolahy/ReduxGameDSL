//
//  GameState+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public extension GameState {

    init(@AttributeBuilder components: () -> [Attribute] = { [] }) {
        for attr in components() {
            if let player = attr as? Player {
                self.players[player.id] = player
                self.playOrder.append(player.id)
            } else if let deck = attr as? Deck {
                self.deck = deck.value
            } else if let discard = attr as? DiscardPile {
                self.discard = discard.value
            } else if let choosable = attr as? Choosable {
                self.choosable = choosable.value
            } else if let chooseOne = attr as? ChooseOne {
                self.chooseOne = chooseOne.value
            }
        }
    }

    func isOver(_ value: Bool) -> Self {
        copy { $0.isOver = value }
    }

    func turn(_ value: String) -> Self {
        copy { $0.turn = value }
    }
}

private extension GameState {
    func copy(closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
