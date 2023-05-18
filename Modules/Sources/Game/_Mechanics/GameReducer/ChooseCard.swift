//
//  ChooseCard.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

struct ChooseCard: GameReducerProtocol {
    let player: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state.arena?.remove(card)
        if state.arena?.cards.isEmpty == true {
            state.arena = nil
        }
        state[keyPath: \GameState.players[player]]?.hand.add(card)
        return state
    }
}

struct EffectChooseCard: EffectResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard let target = ctx.target else {
            throw GameError.noPlayer(.target)
        }

        return try CardArg.selectArena.resolve(state: state, ctx: ctx, chooser: target, owner: nil) {
            .chooseCard(player: target, card: $0)
        }
    }
}
