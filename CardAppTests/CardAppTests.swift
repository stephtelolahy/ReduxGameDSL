//
//  CardAppTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//
@testable import CardApp
import XCTest

final class CardAppTests: XCTestCase {

    func test_FlowMain() {
        // Given
        // When
        let initialState = AppState(screens: [.splash])
        let store = CardAppStore(initial: initialState,
                          reducer: AppState.reducer,
                          middlewares: [])

        store.dispatch(.showScreen(.game(id: "g1")))
        store.dispatch(.game(.playCard(id: "c1", actor: "p1")))
        store.dispatch(.game(.endTurn(actor: "p1")))
        store.dispatch(.game(.playCard(id: "c2", actor: "p2")))
        store.dispatch(.dismissScreen(.game(id: "g1")))

        // Assert
    }
}
