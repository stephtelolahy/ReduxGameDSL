//
//  PlayerSelectAnyWithCard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let playerSelectAnyWithCard: ArgPlayerResolver
 = { _, state, ctx in
     let others = state.players
         .filter { !($0.hand.cards + $0.inPlay.cards).isEmpty }
         .map(\.id)
         .filter { $0 != ctx.actor }
     guard !others.isEmpty else {
         throw GameError.noPlayerAllowed
     }

     return .selectable(others.toOptions())
}
