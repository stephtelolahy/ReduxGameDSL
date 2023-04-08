//
//  PlayerHealthTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerHealthTests: XCTestCase {

    func test_InitialHealthIsZero() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.health, 0)
    }

    func test_GetHealth() {
        // Given
        // When
        let sut = Player().health(2)

        // Then
        XCTAssertEqual(sut.health, 2)
    }
}
