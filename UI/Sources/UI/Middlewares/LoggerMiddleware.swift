//
//  LoggerMiddleware.swift
//  CardApp
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Combine
import Redux

let loggerMiddleware: Middleware<AppState, Action> = { state, action in
    let stateDescription = "\(state)".replacingOccurrences(of: "CardApp.", with: "")
    let actionDescription = "\(action)".replacingOccurrences(of: "CardApp.", with: "")
    print("➡️ \(actionDescription)\n✅ \(stateDescription)\n")

    return Empty().eraseToAnyPublisher()
}
