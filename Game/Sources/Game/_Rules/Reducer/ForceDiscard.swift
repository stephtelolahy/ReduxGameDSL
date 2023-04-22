//
//  ForceDiscard.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct ForceDiscard: GameReducerProtocol {
    let action: GameAction
    let player: PlayerArg
    let card: CardArg
    let otherwise: CardEffect
    let ctx: EffectContext

    func reduce(state: GameState) throws -> GameState {
        var state = state

        // resolve player
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.forceDiscard(player: .id($0), card: card, otherwise: otherwise).withCtx(ctx)
            }
        }

        // resolving card
        let resolvedCard = try CardArgResolver().resolve(arg: card, state: state, ctx: ctx, chooser: pId, owner: pId)
        guard case let .selectable(cIdOptions) = resolvedCard else {
            fatalError(.unexpected)
        }

        // request a choice:
        // - discard one of matching card
        // - or Pass
        state.chooseOne = cIdOptions.reduce(into: [String: GameAction]()) {
            $0[$1.label] = .apply(.discard(player: player, card: .id($1.id)), ctx: ctx)
        }
        state.chooseOne?[Label.pass] = otherwise.withCtx(ctx)

        return state
    }
}
