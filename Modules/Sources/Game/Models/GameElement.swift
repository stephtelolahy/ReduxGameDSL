//
//  GameElement.swift
//  
//
//  Created by Hugues Telolahy on 06/05/2023.
//

/// Element
public protocol GameElement {

    /// Attributes
    var attributes: [AttributeKey: Int] { get }

    /// Abilities
    /// Sorted by priority
    var abilities: [String] { get }
}
