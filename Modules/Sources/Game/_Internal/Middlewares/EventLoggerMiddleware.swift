//
//  EventLoggerMiddleware.swift
//  
//
//  Created by Hugues Telolahy on 03/06/2023.
//
import Redux
import Combine

let eventLoggerMiddleware: Middleware<GameState, GameAction> = { state, action in
    if #available(macOS 13.0, *) {
        print("➡️ \(String(describing: action))".replacing("Game.", with: ""))
        if let event = state.event {
            print("✅ \(String(describing: event))".replacing("Game.", with: ""))
        }
        if let error = state.error {
            print("❌ \(String(describing: error))".replacing("Game.", with: ""))
        }
    } else {
        // Fallback on earlier versions
    }
    return Empty().eraseToAnyPublisher()
}