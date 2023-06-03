//
//  EffectContext+Extensions.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

extension EffectContext {
    func getTarget() -> String {
        guard let targetId = target else {
            fatalError(String(describing: GameError.noPlayer(.target)))
        }

        return targetId
    }
}
