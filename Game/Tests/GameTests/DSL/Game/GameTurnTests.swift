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
        let sut = GameState()

        // Then
        XCTAssertNil(sut.turn)
    }

    func test_GameWithTurn() {
        // Given
        // When
        let sut = GameState().turn("p1")

        // Then
        XCTAssertEqual(sut.turn, "p1")
    }
}
