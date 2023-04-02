//
//  CardLocation+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardLocation {

    init(_ visibility: String? = nil, @CardBuilder _ content: () -> [Card] = { [] }) {
        self.visibility = visibility
        self.cards = content()
    }
}
