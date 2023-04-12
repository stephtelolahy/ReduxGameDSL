//
//  PlayerSelectAnyWithCard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let playerSelectAnyWithCard: ArgPlayerResolver
 = { _, state, ctx in
     let others = state.playOrder
         .filter { $0 != ctx.actor }
         .filter { !(state.player($0).hand.cards + state.player($0).inPlay.cards).isEmpty }
     
     guard !others.isEmpty else {
         throw GameError.noPlayerAllowed
     }

     return .selectable(others.toOptions())
}
