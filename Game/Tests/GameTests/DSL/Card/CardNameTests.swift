//
//  CardNameTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class CardNameTests: XCTestCase {

    func test_CardWithName() {
        // Given
        // When
        let sut = Card("c1")

        // Assert
        XCTAssertEqual(sut.name, "c1")
    }
}
