//
//  PlayerNameTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerNameTests: XCTestCase {

    func test_InitialNameIsEmpty() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.name, "")
    }

    func test_GetName() {
        // Given
        // When
        let sut = Player().name("p1")

        // Then
        XCTAssertEqual(sut.name, "p1")
    }
}
