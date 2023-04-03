//
//  GameTurnTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GameTurnTests: XCTestCase {

    func test_GameWithoutTurn() {
        // Given
        // When
        let sut = Game()

        // Assert
        XCTAssertNil(sut.turn)
    }

    func test_GameWithTurn() {
        // Given
        // When
        let sut = Game().turn("p1")

        // Assert
        XCTAssertEqual(sut.turn, "p1")
    }
}
