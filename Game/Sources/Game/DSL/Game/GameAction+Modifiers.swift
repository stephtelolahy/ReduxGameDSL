//
//  GameAction+Modifiers.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

public extension GameAction {
    static func play(actor: String, card: String) -> Self {
        .play(actor: actor, card: card, target: nil)
    }
}
