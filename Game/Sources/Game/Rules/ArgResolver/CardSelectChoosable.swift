//
//  CardSelectChoosable.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

let cardSelectChoosable: ArgCardResolver
= { _, state, _, _, _ in
    guard let cards = state.choosable?.cards,
          !cards.isEmpty else {
        throw GameError.noChoosableCard
    }

    if cards.count == 1 {
        return .identified([cards[0]])
    } else {
        return .selectable(cards.toOptions())
    }
}
