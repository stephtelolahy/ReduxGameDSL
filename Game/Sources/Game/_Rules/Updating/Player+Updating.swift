//
//  Player+Updating.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

extension Player {
    mutating func removeCard(_ card: String) throws {
        if hand.contains(card) {
            try hand.remove(card)
        } else if inPlay.contains(card) {
            try inPlay.remove(card)
        } else {
            throw GameError.cardNotFound(card)
        }
    }
}
