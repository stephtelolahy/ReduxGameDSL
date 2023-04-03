//
//  EngineMiddleware.swift
//  CardApp
//
//  Created by Hugues Telolahy on 03/04/2023.
//

import Combine

final class EngineMiddleware {

    func middleware(state: AppState, action: AppAction) -> AnyPublisher<AppAction, Never> {
        return Empty().eraseToAnyPublisher()
    }
}
