//
//  PlayerHealthTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerHealthTests: XCTestCase {

    func test_InitialHealthIsZero() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.health, 0)
    }

    func test_GetHealth() {
        // Given
        let sut = Player().health(2)

        // When
        // Assert
        XCTAssertEqual(sut.health, 2)
    }
}
