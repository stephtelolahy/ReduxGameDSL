//
//  CardStack+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public extension CardStack {

    init(@StringBuilder content: () -> [String] = { [] }) {
        cards = content()
    }
}
