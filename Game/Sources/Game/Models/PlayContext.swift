//
//  PlayContext.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

/// Context data associated to an effect
public struct PlayContext: Codable, Equatable {

    /// the actor playing card
    let actor: String

    /// played card
    let card: String

    public init(actor: String, card: String) {
        self.actor = actor
        self.card = card
    }
}
