//
//  PlayerMustangTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerMustangTests: XCTestCase {

    func test_InitialMustangIsZero() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.mustang, 0)
    }

    func test_GetMustang() {
        // Given
        let sut = Player().mustang(1)

        // When
        // Assert
        XCTAssertEqual(sut.mustang, 1)
    }
}
