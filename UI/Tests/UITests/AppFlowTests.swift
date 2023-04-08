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
        // When
        let sut = createAppStore(initial: AppState(screens: [.splash]))

        // Then
        XCTAssertEqual(sut.state.screens, [.splash])
    }
    
    func test_ShowHome_IfDispatchedCompleteSplash() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.splash]))
        
        // When
        sut.dispatch(.showScreen(.home))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }
    
    func test_ShowGame_IfDispatchedStartGame() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.home(HomeState())]))
        
        // When
        sut.dispatch(.showScreen(.game))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(HomeState()),
                                           .game(GamePlayState())])
    }
    
    func test_BackToHome_IfDispatchedQuitGame() {
        // Given
        let sut = createAppStore(initial: AppState(screens: [.home(HomeState()),
                                                             .game(GamePlayState())]))
        
        // When
        sut.dispatch(.dismissScreen(.game))
        
        // Then
        XCTAssertEqual(sut.state.screens, [.home(HomeState())])
    }
}
