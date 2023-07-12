//
//  LoggerMiddleware.swift
//  CardApp
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Combine
import Redux
import UI

public let loggerMiddleware: Middleware<AppState, Action> = { state, action in
    print("➡️ \(action)\n✅ \(state)\n")

    return Empty().eraseToAnyPublisher()
}
