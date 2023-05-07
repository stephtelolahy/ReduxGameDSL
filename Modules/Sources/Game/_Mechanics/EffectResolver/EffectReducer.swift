//
//  EffectReducer.swift
//  
//
//  Created by Hugues Telolahy on 07/05/2023.
//

protocol EffectResolverProtocol {
    func resolve(effect: CardEffect, state: GameState, ctx: EffectContext) throws -> EffectOutput
}

enum EffectOutput {
    case actions([GameAction])
    case chooseOne(ChooseOne)
}

struct EffectReducer: GameReducerProtocol {
    func reduce(state: GameState, action: GameAction) throws -> GameState {
        guard case let .effect(effect, ctx) = action else {
            fatalError(.unexpected)
        }

        var state = state
        let result = try effect.resolver().resolve(effect: effect, state: state, ctx: ctx)
        switch result {
        case let .actions(actions):
            state.queue.insert(contentsOf: actions, at: 0)

        case let .chooseOne(chooseOne):
            state.chooseOne = chooseOne
            state.event = .chooseOne(chooser: chooseOne.chooser, options: Set(chooseOne.options.keys))
        }
        return state
    }
}

private extension CardEffect {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> EffectResolverProtocol {
        switch self {
        case .heal: return Heal()
        case .damage: return Damage()
        case .discard: return Discard()
        case .draw: return Draw()
        case .steal: return Steal()
        case .reveal: return Reveal()
        case .chooseCard: return ChooseCard()
        case .setTurn: return SetTurn()
        case .eliminate: return Eliminate()
        case .forceDiscard: return ForceDiscard()
        case .challengeDiscard: return ChallengeDiscard()
        case .applyEffect: return ApplyEffect()
        case .groupEffects: return GroupEffects()
        case .replayEffect: return ReplayEffect()
        }
    }
}
