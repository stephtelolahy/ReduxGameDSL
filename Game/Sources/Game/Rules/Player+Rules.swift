//
//  Player+Rules.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension Player {
    mutating func gainHealth(_ value: Int) throws {
        health += value
    }
}
