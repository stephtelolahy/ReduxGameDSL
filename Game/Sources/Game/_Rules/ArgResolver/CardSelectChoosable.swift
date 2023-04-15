//
//  CardSelectChoosable.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct CardSelectChoosable: CardArgResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext, chooser: String, owner: String?) throws -> ArgOutput {
        guard let cards = state.choosable?.cards,
              cards.isNotEmpty else {
            throw GameError.noChoosableCard
        }

        if cards.count == 1 {
            return .identified([cards[0]])
        } else {
            return .selectable(cards.toOptions())
        }
    }
}
