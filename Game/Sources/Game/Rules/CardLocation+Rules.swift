//
//  CardLocation+Rules.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardLocation {

    func contains(_ card: String) -> Bool {
        cards.contains(where: { $0 == card })
    }

    mutating func add(_ card: String) {
        cards.append(card)
    }
    
    mutating func remove(_ card: String) throws {
        guard let index = cards.firstIndex(where: { $0 == card }) else {
            throw GameError.missingCard(card)
        }

        cards.remove(at: index)
    }
}
