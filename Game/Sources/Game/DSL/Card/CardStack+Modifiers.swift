//
//  CardStack+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public extension CardStack {

    init(@CardBuilder content: () -> [Card] = { [] }) {
        cards = content()
    }
}
