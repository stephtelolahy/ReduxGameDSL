//
//  Choosable.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

public struct Choosable: GameAttribute {
    private let value: CardLocation

    public init(@StringBuilder _ content: () -> [String]) {
        self.value = CardLocation(cards: content())
    }
    
    public func update(game: inout GameState) {
        game.choosable = value
    }
}
