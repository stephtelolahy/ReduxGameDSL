//
//  CardSelectHandNamed.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct CardSelectHandNamed: CardArgResolverProtocol {
    let name: String

    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> CardArgOutput {
        guard let owner else {
            fatalError(.missingCardOwner)
        }

        let playerObj = state.player(owner)
        let options = playerObj.hand.cards.toCardOptions()

        return .selectable(options)
    }
}
