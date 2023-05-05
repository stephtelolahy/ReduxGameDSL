//
//  CardSelectChoosable.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct CardSelectChoosable: CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        guard let cards = state.choosable?.cards,
              cards.isNotEmpty else {
            throw GameError.choosableIsEmpty
        }

        if cards.count == 1 {
            return .identified([cards[0]])
        } else {
            return .selectable(cards.toCardOptions())
        }
    }
}
