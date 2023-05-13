//
//  Discard.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

struct Discard: GameReducerProtocol {
    let player: String
    let card: String

    func reduce(state: GameState) throws -> GameState {
        var state = state
        try state[keyPath: \GameState.players[player]]?.removeCard(card)
        state.discard.push(card)
        return state
    }
}

struct EffectDiscard: EffectResolverProtocol {
    let player: PlayerArg
    let card: CardArg
    var chooser: PlayerArg?
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .id(pId) = player else {
            return try player.resolve(state: state, ctx: ctx) {
                CardEffect.discard(player: .id($0), card: card, chooser: chooser).withCtx(ctx)
            }
        }

        var chooserId = pId
        if let chooser {
            guard case let .id(cId) = chooser else {
                return try chooser.resolve(state: state, ctx: ctx) {
                    CardEffect.discard(player: player, card: card, chooser: .id($0)).withCtx(ctx)
                }
            }
            chooserId = cId
        }

        return try card.resolve(state: state, ctx: ctx, chooser: chooserId, owner: pId) {
            .discard(player: pId, card: $0)
        }
    }
}
