//
//  GameState+Inventory.swift
//  
//
//  Created by Hugues Telolahy on 25/04/2023.
//

import Game

func createGameWithCardRef(@GameAttributeBuilder components: () -> [GameAttribute]) -> GameState {
    .init(components: components)
    .cardRef(CardList.all)
}
