//
//  LoggerMiddleware.swift
//  CardApp
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Combine

final class LoggerMiddleware {

    func middleware(state: AppState, action: AppAction) -> AnyPublisher<AppAction, Never> {
        let stateDescription = "\(state)".replacingOccurrences(of: "CardApp.", with: "")
        print("➡️ \(action)\n✅ \(stateDescription)\n")

        return Empty().eraseToAnyPublisher()
    }
}
