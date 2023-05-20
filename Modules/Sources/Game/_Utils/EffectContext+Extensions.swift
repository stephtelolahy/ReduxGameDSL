//
//  EffectContext+Extensions.swift
//  
//
//  Created by Hugues Telolahy on 20/05/2023.
//

extension EffectContext {
    func getTarget() throws -> String {
        guard let targetId = target else {
            throw GameError.noPlayer(.target)
        }

        return targetId
    }
}
