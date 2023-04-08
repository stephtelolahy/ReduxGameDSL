//
//  PlayerMustangTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerMustangTests: XCTestCase {

    func test_InitialMustangIsZero() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.mustang, 0)
    }

    func test_GetMustang() {
        // Given
        // When
        let sut = Player().mustang(1)

        // Then
        XCTAssertEqual(sut.mustang, 1)
    }
}
