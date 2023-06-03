//
//  EffectContext+Extensions.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

extension EffectContext {
    func getTarget() -> String {
        guard let target else {
            fatalError("No target")
        }

        return target
    }

    func getCardSelected() -> String {
        guard let cardSelected else {
            fatalError("No selected card")
        }

        return cardSelected
    }

    func copy(target: String) -> Self {
        var copy = self
        copy.target = target
        return copy
    }

    func copy(cardSelected: String) -> Self {
        var copy = self
        copy.cardSelected = cardSelected
        return copy
    }
}
