//
//  PlayerTarget.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

let playerTarget: ArgPlayerResolver
= { _, _, ctx in
    guard let target = ctx.target else {
        throw GameError.missingTarget
    }

    return .identified([target])
}