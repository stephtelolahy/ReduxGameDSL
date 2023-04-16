//
//  CardSelectAny.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct CardSelectAny: CardArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> CardArgOutput {
        guard let owner else {
            fatalError(.missingCardOwner)
        }

        let playerObj = state.player(owner)
        var options: [CardArgOption] = []

        if playerObj.inPlay.cards.isNotEmpty {
            let inPlayOptions = playerObj.inPlay.cards.toCardOptions()
            options.append(contentsOf: inPlayOptions)
        }

        if playerObj.hand.cards.isNotEmpty {
            if chooser != owner {
                let randomId = playerObj.hand.cards.randomElement().unsafelyUnwrapped
                let randomOption = CardArgOption(id: randomId, label: Label.randomHand)
                options.append(randomOption)
            } else {
                let handOptions = playerObj.hand.cards.toCardOptions()
                options.append(contentsOf: handOptions)
            }
        }

        guard options.isNotEmpty else {
            throw GameError.playerHasNoCard(owner)
        }

        return .selectable(options)
    }
}
