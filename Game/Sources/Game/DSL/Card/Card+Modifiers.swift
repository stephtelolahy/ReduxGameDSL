//
//  Card+Modifiers.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import Foundation

public extension Card {

    init(_ id: String = UUID().uuidString) {
        self.id = id
    }
}
