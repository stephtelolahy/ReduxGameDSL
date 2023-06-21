//
//  EffectLuck.swift
//
//
//  Created by Hugues Stephano TELOLAHY on 22/06/2023.
//

struct EffectLuck: EffectResolverProtocol {
    let regex: String
    let onSuccess: CardEffect
    
    func resolve(state: GameState, ctx: EffectContext) throws -> [GameAction] {
        guard let topDeck = state.deck.top else {
            throw GameError.deckIsEmpty
        }
        
        var result: [GameAction] = [.luck]
        
        let matched = topDeck.contains(regex)
        if matched {
            result.append(.resolve(onSuccess, ctx: ctx))
        }
        
        return result
    }
}
