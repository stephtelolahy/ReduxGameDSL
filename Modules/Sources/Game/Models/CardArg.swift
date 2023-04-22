//
//  CardArg.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

/// Card argument
public enum CardArg: Codable, Equatable {

    /// Card identified by
    case id(String)

    /// Select any player's hand or inPlay card
    case selectAny

    /// Select any choosable card
    case selectChoosable

    /// Select any self's hand card matching given name
    case selectHandNamed(String)
}