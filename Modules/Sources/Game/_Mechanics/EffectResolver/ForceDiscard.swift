//
//  ForceDiscard.swift
//  
//
//  Created by Hugues Telolahy on 16/04/2023.
//

struct ForceDiscard: EffectResolverProtocol {
    let player: PlayerArg
    let card: CardArg
    let otherwise: CardEffect
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx) {
                CardEffect.forceDiscard(player: .id($0), card: card, otherwise: otherwise).withCtx(ctx)
            }
        }

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
