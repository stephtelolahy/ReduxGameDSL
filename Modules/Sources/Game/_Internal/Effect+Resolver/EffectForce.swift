//
//  EffectForce.swift
//  
//
//  Created by Hugues Telolahy on 13/05/2023.
//

struct EffectForce: EffectResolverProtocol {
    let effect: CardEffect
    let otherwise: CardEffect

    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        do {
            let children = try effect.resolve(state: state, ctx: ctx)

            guard children.count == 1 else {
                fatalError("unexpected")
            }

            let action = children[0]
            switch action {
            case let .resolve(childEffect, childCtx):
                return [.resolve(.force(childEffect, otherwise: otherwise), ctx: childCtx)]

            case let .chooseOne(chooser, options):
                var options = options
                options[.pass] = .resolve(otherwise, ctx: ctx)
                return [.chooseOne(player: chooser, options: options)]

            default:
                fatalError("unexpected")
            }
        } catch {
            return [.chooseOne(player: ctx.get(.target),
                               options: [.pass: .resolve(otherwise, ctx: ctx)])]
        }
    }
}
