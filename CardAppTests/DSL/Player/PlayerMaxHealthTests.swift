//
//  PlayerMaxHealthTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerMaxHealthTests: XCTestCase {

    func test_InitialMaxHealthIsZero() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.maxHealth, 0)
    }

    func test_GetMaxHealth() {
        // Given
        let sut = Player().maxHealth(4)

        // When
        // Assert
        XCTAssertEqual(sut.maxHealth, 4)
    }
}
