//
//  CardSelectAny.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let cardSelectAny: ArgCardResolver
= { _, state, _, chooser, owner in
    let playerObj = state.player(owner)
    var options: [ArgOption] = []

    if !playerObj.inPlay.cards.isEmpty {
        let inPlayOptions = playerObj.inPlay.cards.toOptions()
        options.append(contentsOf: inPlayOptions)
    }

    if !playerObj.hand.cards.isEmpty {
        if chooser != owner {
            // swiftlint:disable:next force_unwrapping
            let randomId = playerObj.hand.cards.randomElement()!
            let randomOption = ArgOption(id: randomId, label: Label.randomHand)
            options.append(randomOption)
        } else {
            let handOptions = playerObj.hand.cards.toOptions()
            options.append(contentsOf: handOptions)
        }
    }

    if options.isEmpty {
        throw GameError.playerHasNoCard(owner)
    }

    return .selectable(options)
}