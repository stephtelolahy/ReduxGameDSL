//
//  CardStack.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

/// Stack of cards
struct CardStack: Codable, Equatable {
    
    /// number of cards in the stack
    var count: Int = 0
    
    /// Looks at the card at the top of this stack without removing it from the stack.
    var top: Card?
    
    /// Content
    var content: [Card] = []
}
