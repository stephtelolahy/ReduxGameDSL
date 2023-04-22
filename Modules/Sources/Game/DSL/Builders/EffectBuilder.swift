//
//  EffectBuilder.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

@resultBuilder
public struct EffectsBuilder {

    public static func buildBlock(_ components: CardEffect...) -> [CardEffect] {
        components
    }
}

@resultBuilder
public struct EffectBuilder {

    public static func buildBlock(_ component: CardEffect) -> CardEffect {
        component
    }
}
