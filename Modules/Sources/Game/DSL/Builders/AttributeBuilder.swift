//
//  AttributeBuilder.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

import Foundation

@resultBuilder
public struct AttributeBuilder {

    public static func buildBlock(_ components: Attribute...) -> [Attribute] {
        components
    }
}
