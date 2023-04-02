//
//  AttributeBuilder.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//

import Foundation

@resultBuilder
struct AttributeBuilder {

    static func buildBlock(_ components: any Attribute...) -> [any Attribute] {
        components
    }
}
