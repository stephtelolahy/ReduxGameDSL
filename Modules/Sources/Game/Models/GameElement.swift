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

    /// Abilities implemented with Card having the same name
    var abilities: Set<String> { get }
}
