//
//  AttributeKey.swift
//  
//
//  Created by Hugues Telolahy on 06/05/2023.
//

public enum AttributeKey: String, Codable, CodingKeyRepresentable {

    /// max health
    case bullets

    /// life points
    case health

    /// max number of cards at end of turn, default: health
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
