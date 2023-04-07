//
//  AppFlowTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//
@testable import UI
import Redux
import XCTest

final class AppFlowTests: XCTestCase {
    
    func test_ShowSplash_AsInitialScreen() {
        // Given
        let sut = createStore(initial: AppState(screens: [.splash]))
        
        // When
        // Assert
        XCTAssertEqual(sut.state.screens, [.splash])
    }
    
    func test_ShowHome_IfDispatchedCompleteSplash() {
        // Given
        let sut = createStore(initial: AppState(screens: [.splash]))
        
        // When
        sut.dispatch(.showScreen(.home))
        
        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }
    
    func test_ShowGame_IfDispatchedStartGame() {
        // Given
        let sut = createStore(initial: AppState(screens: [.home(HomeState())]))
        
        // When
        sut.dispatch(.showScreen(.game))
        
        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState()),
                                           .game(GamePlayState())])
    }
    
    func test_BackToHome_IfDispatchedQuitGame() {
        // Given
        let sut = createStore(initial: AppState(screens: [.home(HomeState()),
                                                          .game(GamePlayState())]))
        
        // When
        sut.dispatch(.dismissScreen(.game))
        
        // Assert
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }
}

private func createStore(initial: AppState) -> Store<AppState, Action> {
    Store(initial: initial,
          reducer: AppState.reducer,
          middlewares: [])
}
