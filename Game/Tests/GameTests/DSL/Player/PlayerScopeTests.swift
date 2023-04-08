//
//  PlayerScopeTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerScopeTests: XCTestCase {

    func test_InitialScopeIsZero() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.scope, 0)
    }

    func test_GetScope() {
        // Given
        // When
        let sut = Player().scope(1)

        // Then
        XCTAssertEqual(sut.scope, 1)
    }
}
