//
//  CardSelectHandNamed.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct CardSelectHandNamed: CardArgResolverProtocol {
    func resolve(
        arg: CardArg,
        state: GameState,
        ctx: EffectContext,
        chooser: String,
        owner: String?
    ) throws -> CardArgOutput {
        guard case let .selectHandNamed(name) = arg else {
            fatalError(.unexpected)
        }

        guard let owner else {
            fatalError(.unexpected)
        }

        let playerObj = state.player(owner)
        let options = playerObj.hand.cards
            .filter { $0.extractName() == name }
            .toCardOptions()

        return .selectable(options)
    }
}
