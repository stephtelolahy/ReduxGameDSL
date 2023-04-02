//
//  CardIdTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import XCTest

final class CardIdTests: XCTestCase {

    func test_CardWithDefaultId() {
        // Given
        // When
        let sut = Card()

        // Assert
        XCTAssertFalse(sut.id.isEmpty)
    }

    func test_CardWithId() {
        // Given
        // When
        let sut = Card(id: "c1")

        // Assert
        XCTAssertEqual(sut.id, "c1")
    }
}
