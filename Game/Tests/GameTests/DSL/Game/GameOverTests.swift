//
//  GameOverTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GameOverTests: XCTestCase {

    func test_GameIsNotOver_ByDefault() {
        // Given
        // When
        let sut = GameState()

        // Assert
        XCTAssertFalse(sut.isOver)
    }

    func test_GameIsOver() {
        // Given
        // When
        let sut = GameState().isOver(true)

        // Assert
        XCTAssertTrue(sut.isOver)
    }
}
