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
}
