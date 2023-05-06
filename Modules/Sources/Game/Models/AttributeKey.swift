//
//  AttributeKey.swift
//  
//
//  Created by Hugues Telolahy on 06/05/2023.
//

/// Game element attributes
public enum AttributeKey: String, Codable, CodingKeyRepresentable {

    /// max health
    case bullets

    /// life points
    case health

    /// override maximum allowed hand cards at the end of his turn
    /// by default health is maximum allowed hand cards
    case handLimit

    /// gun range, default: 1
    case weapon

    /// increment distance from others
    case mustang

    /// decrement distance to others
    case scope

    /// Cards to draw at beginning of turn
    case starTurnCards

    /// number of flipped cards on a draw, default: 1
    case flippedCards

    /// number of 'missed' required to cancel your bang, default: 1
    case bangsCancelable

    /// number of bangs per turn, default: 1
    case bangsPerTurn
}
