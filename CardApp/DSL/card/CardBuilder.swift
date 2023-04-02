//
//  CardBuilder.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

@resultBuilder
struct CardBuilder {

    static func buildBlock(_ components: Card...) -> [Card] {
        components
    }

    static func buildExpression(_ card: Card) -> Card {
        card
    }

    static func buildExpression(_ id: String) -> Card {
        Card(id: id)
    }
}
