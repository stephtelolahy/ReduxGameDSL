//
//  MustChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

public struct MustChooseOne: GameAttribute {
    private let value: ChooseOne

    public init(_ chooser: String, content: () -> [String: GameAction]) {
        self.value = ChooseOne(chooser: chooser, options: content())
    }
    
    public func update(game: inout GameState) {
        game.chooseOne = value
    }
}
