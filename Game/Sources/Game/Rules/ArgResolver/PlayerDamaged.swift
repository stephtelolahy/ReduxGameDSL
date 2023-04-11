//
//  PlayerDamaged.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let playerDamaged: ArgPlayerResolver
= { _, state, ctx in
    let damaged = state.players.map(\.id)
        .starting(with: ctx.actor)
        .filter { state.player($0).health < state.player($0).maxHealth }

    if damaged.isEmpty {
        throw GameError.noPlayerDamaged
    }

    return .identified(damaged)
}
