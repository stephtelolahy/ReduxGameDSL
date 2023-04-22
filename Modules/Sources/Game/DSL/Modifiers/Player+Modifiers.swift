//
//  Player+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

public extension Player {

    init(_ id: String = UUID().uuidString, @AttributeBuilder components: () -> [Attribute] = { [] }) {
        self.id = id
        for attr in components() {
            if let hand = attr as? Hand {
                self.hand = hand.value
            } else if let inPlay = attr as? InPlay {
                self.inPlay = inPlay.value
            } else if let abilities = attr as? Abilities {
                self.abilities = abilities.value
            }
        }
    }

    func name(_ value: String) -> Self {
        copy { $0.name = value }
    }

    func maxHealth(_ value: Int) -> Self {
        copy { $0.maxHealth = value }
    }

    func health(_ value: Int) -> Self {
        copy { $0.health = value }
    }

    func handLimit(_ value: Int) -> Self {
        copy { $0.handLimit = value }
    }

    func weapon(_ value: Int) -> Self {
        copy { $0.weapon = value }
    }

    func mustang(_ value: Int) -> Self {
        copy { $0.mustang = value }
    }

    func scope(_ value: Int) -> Self {
        copy { $0.scope = value }
    }
}

private extension Player {
    func copy(closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
