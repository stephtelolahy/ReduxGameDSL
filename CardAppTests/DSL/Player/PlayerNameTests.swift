//
//  PlayerNameTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerNameTests: XCTestCase {

    func test_InitialNameIsEmpty() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.name, "")
    }

    func test_GetName() {
        // Given
        let sut = Player().name("p1")

        // When
        // Assert
        XCTAssertEqual(sut.name, "p1")
    }
}
