//
//  ChallengeDiscard.swift
//  
//
//  Created by Hugues Telolahy on 23/04/2023.
//

struct ChallengeDiscard: GameReducerProtocol {
    let player: PlayerArg
    let card: CardArg
    let otherwise: GameAction
    let challenger: PlayerArg
    let ctx: EffectContext?

    func reduce(state: GameState) throws -> GameState {
        var state = state

        // resolve player
        guard case let .id(pId) = player else {
            return try PlayerArgResolver().resolve(arg: player, state: state, ctx: ctx!) {
                .forceDiscard(player: .id($0), card: card, otherwise: otherwise, ctx: ctx)
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
            let discardEffect = GameAction.discard(player: player, card: .id($1.id), ctx: ctx)
            let reverseEffect = GameAction.challengeDiscard(player: challenger,
                                                            card: card,
                                                            otherwise: otherwise,
                                                            challenger: player,
                                                            ctx: ctx)
            $0[$1.label] = .group {
                discardEffect
                reverseEffect
            }
        }
        options[.pass] = otherwise.withCtx(ctx!)
        state.chooseOne = ChooseOne(chooser: pId, options: options)

        return state
    }
}
