//
//  ForceDiscard.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct ForceDiscard: GameReducerProtocol {
    let player: PlayerArg
    let card: CardArg
    let otherwise: CardEffect
    let ctx: EffectContext?

    func reduce(state: GameState) throws -> GameState {
        var state = state

        // resolve player
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx!) {
                CardEffect.forceDiscard(player: .id($0), card: card, otherwise: otherwise).withCtx(ctx)
            }
        }

        // resolving card
        let resolvedCard = try CardArgResolver().resolve(arg: card, state: state, ctx: ctx!, chooser: pId, owner: pId)
        guard case let .selectable(cIdOptions) = resolvedCard else {
            fatalError(.unexpected)
        }

        // request a choice:
        // - discard one of matching card
        // - or Pass
        var options = cIdOptions.reduce(into: [String: GameAction]()) {
            $0[$1.label] = CardEffect.discard(player: player, card: .id($1.id)).withCtx(ctx)
        }
        options[.pass] = otherwise.withCtx(ctx)
        state.queue.insert(.chooseOne(chooser: pId, options: options), at: 0) 
        
        return state
    }
}
