//
//  EffectContext.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Context data associated to an effect
public struct EffectContext: Codable, Equatable {

    /// the actor playing card
    let actor: String

    /// played card
    let card: String

    /// targeted player
    var target: String?

    /// selected card
    var cardSelected: String?

    public init(actor: String, card: String, target: String? = nil) {
        self.actor = actor
        self.card = card
        self.target = target
    }
}
