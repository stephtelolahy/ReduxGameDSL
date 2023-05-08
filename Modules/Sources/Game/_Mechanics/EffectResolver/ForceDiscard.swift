//
//  ForceDiscard.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct ForceDiscard: EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .forceDiscard(player, card, otherwise) = effect else {
            fatalError(.unexpected)
        }
        
        // resolve player
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolving(arg: player, state: state, ctx: ctx) {
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
        var options = cIdOptions.reduce(into: [String: GameAction]()) {
            $0[$1.label] = .discard(player: pId, card: $1.id)
        }
        options[.pass] = otherwise.withCtx(ctx)
        
        return [.chooseAction(chooser: pId, options: options)]
    }
}
