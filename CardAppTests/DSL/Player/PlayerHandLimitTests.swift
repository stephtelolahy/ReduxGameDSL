//
//  PlayerHandLimitTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerHandLimitTests: XCTestCase {

    func test_InitialHandLimitIsZero() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.handLimit, 0)
    }

    func test_GetHandLimit() {
        // Given
        let sut = Player().handLimit(10)

        // When
        // Assert
        XCTAssertEqual(sut.handLimit, 10)
    }
}
