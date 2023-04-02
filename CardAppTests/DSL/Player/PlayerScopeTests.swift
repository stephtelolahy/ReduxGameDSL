//
//  PlayerScopeTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerScopeTests: XCTestCase {

    func test_InitialScopeIsZero() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.scope, 0)
    }

    func test_GetScope() {
        // Given
        let sut = Player().scope(1)

        // When
        // Assert
        XCTAssertEqual(sut.scope, 1)
    }
}
