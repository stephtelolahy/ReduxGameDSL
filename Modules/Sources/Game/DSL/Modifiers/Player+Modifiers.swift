//
//  Player+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

public extension Player {

    init(_ id: String = UUID().uuidString, @PlayerAttributeBuilder components: () -> [PlayerAttribute] = { [] }) {
        self.id = id
        attributes = [
            .weapon: 1,
            .starTurnCards: 2
        ]
        components().forEach { $0.update(player: &self) }
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

    func attribute(_ key: AttributeKey, value: Int) -> Self {
        copy { $0.attributes[key] = value }
    }
    
    func abilities(_ value: [String]) -> Self {
        copy { $0.abilities = value }
    }
}

private extension Player {
    func copy(closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
