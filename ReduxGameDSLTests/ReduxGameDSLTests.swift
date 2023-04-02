//
//  ReduxGameDSLTests.swift
//  ReduxGameDSLTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//
@testable import ReduxGameDSL
import XCTest

final class ReduxGameDSLTests: XCTestCase {

    func test_FlowMain() {
        // Given
        // When
        let initialState = AppState()
        let store = MyAppStore(initial: initialState,
                          reducer: AppState.reducer,
                          middlewares: [])

        store.dispatch(.startGame)
        store.dispatch(.game(.playCard(id: "c1", actor: "p1")))
        store.dispatch(.game(.playCard(id: "c2", actor: "p1")))
        store.dispatch(.game(.endTurn(actor: "p1")))
        store.dispatch(.game(.endGame))

        // Assert
    }
}
