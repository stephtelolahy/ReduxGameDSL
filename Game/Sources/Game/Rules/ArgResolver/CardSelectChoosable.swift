//
//  CardSelectChoosable.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

let cardSelectChoosable: ArgCardResolver
= { _, state, _, _, _ in
    guard let cards = state.choosable?.cards else {
        throw GameError.noChoosableCard
    }

    let options = cards.toOptions()
    return .selectable(options)
}
