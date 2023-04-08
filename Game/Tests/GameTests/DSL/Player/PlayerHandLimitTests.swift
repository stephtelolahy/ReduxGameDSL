//
//  PlayerHandLimitTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerHandLimitTests: XCTestCase {

    func test_InitialHandLimitIsZero() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.handLimit, 0)
    }

    func test_GetHandLimit() {
        // Given
        // When
        let sut = Player().handLimit(10)

        // Then
        XCTAssertEqual(sut.handLimit, 10)
    }
}
