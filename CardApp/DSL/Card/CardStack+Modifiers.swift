//
//  CardStack+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

extension CardStack {
    init(@CardBuilder _ content: () -> [Card] = { [] }) {
        cards = content()
    }
}
