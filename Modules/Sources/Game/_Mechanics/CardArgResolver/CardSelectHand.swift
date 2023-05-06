//
//  CardSelectHand.swift
//  
//
//  Created by Hugues Telolahy on 02/05/2023.
//

struct CardSelectHand: CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        guard let owner else {
            fatalError(.unexpected)
        }

        let playerObj = state.player(owner)
        let options = playerObj.hand.cards.toCardOptions()

        return .selectable(options)
    }
}
