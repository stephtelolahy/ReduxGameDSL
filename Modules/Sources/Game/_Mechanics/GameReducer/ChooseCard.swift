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
    let player: PlayerArg
    let card: CardArg

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.chooseCard(player: .id($0), card: card).withCtx(ctx)
            }
        }

        return try card.resolve(state: state, ctx: ctx, chooser: pId, owner: nil) {
            .chooseCard(player: pId, card: $0)
        }
    }
}
