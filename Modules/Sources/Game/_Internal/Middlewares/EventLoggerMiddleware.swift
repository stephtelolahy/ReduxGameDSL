//
//  EventLoggerMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//
import Redux
import Combine

let eventLoggerMiddleware: Middleware<GameState, GameAction> = { state, _ in
    if let event = state.event {
        let flag = event.isRenderable ? "✅" : "➡️"
        print("\(flag) \(event.loggerDescription)")
    }
    
    if let error = state.error {
        print("❌ \(error.loggerDescription)")
    }
    
    if let active = state.active {
        print("🎲 active: \(active.cards.joined(separator: ", "))")
    }
    
    if let chooseOne = state.chooseOne {
        print("🎲 option: \(chooseOne.options.keys.joined(separator: ", "))")
    }
    
    return Empty().eraseToAnyPublisher()
}

public extension GameAction {
    var loggerDescription: String {
        String(describing: self).removingPackageName()
    }
}

public extension GameError {
    var loggerDescription: String {
        String(describing: self).removingPackageName()
    }
}

private extension String {
    func removingPackageName() -> String {
        if #available(macOS 13.0, *) {
            if #available(iOS 16.0, *) {
                return self
                    .replacing("Game.", with: "")
                    .replacing("CardEffect.", with: "")
                    .replacing("CardArg.", with: "")
                    .replacing("PlayerArg.", with: "")
                    .replacing("NumArg.", with: "")
                    .replacing("ContextKey.", with: "")
                    .replacing("GameAction.", with: "")
                    .replacing("AttributeKey.", with: "")
            }
        }
        return self
    }
}
