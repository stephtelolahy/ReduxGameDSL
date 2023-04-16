//
//  CardStack+Updating.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardStack {

    mutating func push(_ card: String) {
        cards.insert(card, at: 0)
    }
}
