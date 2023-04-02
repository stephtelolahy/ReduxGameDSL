//
//  GameOverTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import XCTest

final class GameOverTests: XCTestCase {

    func test_GameIsNotOver_ByDefault() {
        // Given
        // When
        let sut = Game()

        // Assert
        XCTAssertFalse(sut.isOver)
    }

    func test_GameIsOver() {
        // Given
        // When
        let sut = Game().isOver(true)

        // Assert
        XCTAssertTrue(sut.isOver)
    }
}
