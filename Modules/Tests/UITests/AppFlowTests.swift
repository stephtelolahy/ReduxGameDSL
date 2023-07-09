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

    private func createAppStore(initial: AppState) -> Store<AppState, Action> {
        Store(initial: initial,
              reducer: AppState.reducer,
              middlewares: [])
    }
    
    func test_App_WhenInitialized_ShouldShowSplashScreen() {
        // Given
        // When
        let sut = createAppStore(initial: AppState(screens: [.splash]))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.splash])
    }
    
    func test_App_WhenCompletedSplash_ShowHomeScreen() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.splash]))
        
        // When
        sut.dispatch(.showScreen(.home))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(.init())])
    }
    
    func test_App_WhenStartedGame_ShouldShowGameScreen() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.home(.init())]))
        
        // When
        sut.dispatch(.showScreen(.game))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(.init()),
                                           .game(.init())])
    }
    
    func test_App_WhenFinishedGame_ShouldBackToHomeScreen() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.home(.init()),
                                                             .game(.init())]))
        
        // When
        sut.dispatch(.dismissScreen(.game))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(.init())])
    }
}
