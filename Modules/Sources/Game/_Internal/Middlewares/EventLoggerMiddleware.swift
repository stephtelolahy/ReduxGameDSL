//
//  EventLoggerMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//
import Redux
import Combine

let eventLoggerMiddleware: Middleware<GameState, GameAction> = { state, action in
    print("➡️ \(String(describing: action).removingPackageName())")
    
    if let event = state.event {
        print("✅ \(String(describing: event).removingPackageName())")
    }
    
    if let error = state.error {
        print("❌ \(String(describing: error).removingPackageName())")
    }
    
    if let active = state.active {
        print("🎲 active: \(active.cards.joined(separator: ", "))")
    }
    
    if let chooseOne = state.chooseOne {
        print("🎲 chooseOne: \(chooseOne.options.keys.joined(separator: ", "))")
    }
    
    return Empty().eraseToAnyPublisher()
}

private extension String {
    func removingPackageName() -> String {
        if #available(macOS 13.0, *) {
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
        return self
    }
}
