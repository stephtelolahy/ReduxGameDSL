//
//  CardEffect+Resolver.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 11/05/2023.
//

extension CardEffect {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        try resolver()
            .resolve(state: state, ctx: ctx)
            .validateChooseOne(state: state)
    }
}

protocol EffectResolverProtocol {
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction]
}

private extension CardEffect {
    // swiftlint:disable:next cyclomatic_complexity
    func resolver() -> EffectResolverProtocol {
        switch self {
        case let .heal(value):
            return EffectBuild { .heal(value, player: $0.get(.target)) }

        case let .damage(value):
            return EffectBuild { .damage(value, player: $0.get(.target)) }

        case .draw:
            return EffectBuild { .draw(player: $0.get(.target)) }

        case .discover:
            return EffectBuild { _ in .discover }

        case .setTurn:
            return EffectBuild { .setTurn($0.get(.target)) }

        case .eliminate:
            return EffectBuild { .eliminate(player: $0.get(.target)) }

        case .chooseCard:
            return EffectChooseCard()

        case let .discard(card, chooser):
            return EffectDiscard(card: card, chooser: chooser)

        case let .steal(card, chooser):
            return EffectSteal(card: card, chooser: chooser)
            
        case let .passInplay(card, owner):
            return EffectPassInPlay(card: card, owner: owner)

            // operation on effect
        case let .target(target, effect):
            return EffectTarget(target: target, effect: effect)

        case let .group(effects):
            return EffectGroup(effects: effects)

        case let .repeat(times, effect):
            return EffectRepeat(effect: effect, times: times)

        case let .force(effect, otherwise):
            return EffectForce(effect: effect, otherwise: otherwise)

        case let .challenge(challenger, effect, otherwise):
            return EffectChallenge(challenger: challenger, effect: effect, otherwise: otherwise)
            
        case .nothing:
            return EffectNone()
            
        case let .luck(regex, onSuccess, onFailure):
            return EffectLuck(regex: regex, onSuccess: onSuccess, onFailure: onFailure)
            
        case let .cancel(arg):
            return EffectBuild { _ in .cancel(arg) }

        case .evaluateGameOver:
            return EffectEvaluateGameOver()
            
        default:
            fatalError("unimplemented effect \(self)")
        }
    }
}

private extension Array where Element == GameAction {
    func validateChooseOne(state: GameState) throws -> Self {
        guard self.count == 1,
              case .chooseOne(let chooser, var options) = self[0] else {
            return self
        }

        var keysToRemove: [String] = []
        for (key, action) in options {
            do {
                try action.validate(state: state)
                if case let .resolve(effect, ctx) = action {
                    let childActions = try effect
                        .resolver()
                        .resolve(state: state, ctx: ctx)
                    if childActions.count == 1 {
                        options[key] = childActions[0]
                    }
                }
            } catch {
                print("!!! ignored option \(action) due to error \(error)")
                keysToRemove.append(key)
                continue
            }
        }

        for key in keysToRemove {
            options.removeValue(forKey: key)
        }

        assert(!options.isEmpty, "expected non empty actions")

        return [.chooseOne(player: chooser, options: options)]
    }
}
