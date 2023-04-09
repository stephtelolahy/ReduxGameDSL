//
//  Player+Updating.swift
//  
//
//  Created by Hugues Telolahy on 09/04/2023.
//

extension Player {
    mutating func gainHealth(_ value: Int) throws {
        guard health < maxHealth else {
            throw GameError.playerAlreadyMaxHealth(id)
        }

        let newHealth = min(health + value, maxHealth)
        health = newHealth
    }
}
