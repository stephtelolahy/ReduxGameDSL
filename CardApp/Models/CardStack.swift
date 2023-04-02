//
//  CardStack.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Stack of cards
struct CardStack: Codable, Equatable {
    
    /// number of cards in the stack
    var count: Int { cards.count }
    
    /// Looks at the card at the top of this stack without removing it from the stack.
    var top: Card? { cards.first }
    
    /// Content
    var cards: [Card] = []
}
