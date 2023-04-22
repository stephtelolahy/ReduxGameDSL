//
//  CardActionInfoBuilder.swift
//  
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Foundation

@resultBuilder
public struct CardActionInfoBuilder {

    public static func buildBlock(_ components: CardActionInfo...) -> [CardActionInfo] {
        components
    }
}
