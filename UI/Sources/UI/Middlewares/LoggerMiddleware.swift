//
//  LoggerMiddleware.swift
//  CardApp
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Combine

final class LoggerMiddleware {

    func middleware(state: AppState, action: Action) -> AnyPublisher<Action, Never> {
        let stateDescription = "\(state)".replacingOccurrences(of: "CardApp.", with: "")
        let actionDescription = "\(action)".replacingOccurrences(of: "CardApp.", with: "")
        print("➡️ \(actionDescription)\n✅ \(stateDescription)\n")

        return Empty().eraseToAnyPublisher()
    }
}
