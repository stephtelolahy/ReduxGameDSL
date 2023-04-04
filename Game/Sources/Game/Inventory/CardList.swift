//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 04/04/2023.
//

public struct CardList {
    let cards: [String: Card]

    public init(@CardBuilder _ content: () -> [Card]) {
        self.cards = content().toDictionary()
    }
}

private extension Array where Element == Card {
    func toDictionary() -> [String: Card] {
        reduce(into: [String: Card]()) {
            $0[$1.name] = $1
        }
    }
}
