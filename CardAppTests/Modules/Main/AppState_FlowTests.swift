//
//  AppState_FlowTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import XCTest

final class AppState_FlowTests: XCTestCase {

    func test_ShowSplash_AsInitialScreen() {
        // Given
        let sut = CardAppStore.create()

        // When
        // Assert
        XCTAssertEqual(sut.state.screens, [.splash])
    }

    func test_ShowHome_IfDispatchedCompleteSplash() {
        // Given
        let sut = CardAppStore.create()

        // When
        sut.dispatch(.showScreen(.home))

        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }

    func test_ShowGame_IfDispatchedStartGame() {
        // Given
        let sut = CardAppStore.create(initial: AppState(screens: [.home(HomeState())]))

        // When
        sut.dispatch(.showScreen(.game))

        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState()),
                                           .game(GameState())])
    }

    func test_BackToHome_IfDispatchedQuitGame() {
        // Given
        let sut = CardAppStore.create(initial: AppState(screens: [.home(HomeState()),
                                                                  .game(GameState())]))

        // When
        sut.dispatch(.dismissScreen(.game))

        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }

}
