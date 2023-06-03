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

    func getSelected() -> String {
        guard let selected else {
            fatalError("No selected card")
        }

        return selected
    }

    func copy(target: String) -> Self {
        var copy = self
        copy.target = target
        return copy
    }

    func copy(selected: String) -> Self {
        var copy = self
        copy.selected = selected
        return copy
    }
}
