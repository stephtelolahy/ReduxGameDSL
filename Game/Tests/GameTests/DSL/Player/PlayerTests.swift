//
//  PlayerTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class PlayerTests: XCTestCase {

    func test_PlayerWitDefaultId() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertFalse(sut.id.isEmpty)
    }

    func test_PlayerWithId() {
        // Given
        // When
        let sut = Player("p1")

        // Then
        XCTAssertEqual(sut.id, "p1")
    }
}
