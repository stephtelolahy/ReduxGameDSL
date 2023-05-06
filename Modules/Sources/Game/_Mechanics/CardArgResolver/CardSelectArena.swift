//
//  CardSelectArena.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct CardSelectArena: CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        guard let cards = state.arena?.cards,
              cards.isNotEmpty else {
            throw GameError.noCard(arg)
        }

        if cards.count == 1 {
            return .identified([cards[0]])
        } else {
            return .selectable(cards.toCardOptions())
        }
    }
}
