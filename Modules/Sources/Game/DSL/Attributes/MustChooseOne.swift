//
//  MustChooseOne.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

// TODO: replace with Queueing(...)
public struct MustChooseOne: GameAttribute {
    let value: GameAction

    public init(_ chooser: String, content: () -> [String: GameAction]) {
        self.value = .chooseOne(chooser: chooser, options: content())
    }
    
    public func update(game: inout GameState) {
        game.queue.insert(value, at: 0)
    }
}
