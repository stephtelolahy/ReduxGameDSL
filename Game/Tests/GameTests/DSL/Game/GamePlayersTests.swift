//
//  GamePlayersTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GamePlayersTests: XCTestCase {

    func testGameWithoutPlayers() {
        // Given
        // When
        let sut = GameState()

        // Then
        XCTAssertTrue(sut.players.isEmpty)
    }

    func test_GameWithOnePlayer() {
        // Given
        // When
        let sut = GameState {
            Player("p1")
        }

        // Then
        XCTAssertEqual(sut.players.map(\.id), ["p1"])
    }

    func test_GameWithTwoPlayers() {
        // Given
        // When
        let sut = GameState {
            Player("p1")
            Player("p2")
        }

        // Then
        XCTAssertEqual(sut.players.map(\.id), ["p1", "p2"])
    }
}
