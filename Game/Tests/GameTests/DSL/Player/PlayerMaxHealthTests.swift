//
//  PlayerMaxHealthTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerMaxHealthTests: XCTestCase {

    func test_InitialMaxHealthIsZero() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.maxHealth, 0)
    }

    func test_GetMaxHealth() {
        // Given
        // When
        let sut = Player().maxHealth(4)

        // Then
        XCTAssertEqual(sut.maxHealth, 4)
    }
}
