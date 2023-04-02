//
//  CardStackModifiersTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import XCTest

final class CardStackModifiersTests: XCTestCase {

    func test_CardStackIsInitiallyEmpty() {
        // Given
        let sut = CardStack()

        // When
        // Assert
        XCTAssertEqual(sut.count, 0)
    }

    func test_CardStackContainsOneCard() {
        // Given
        let sut = CardStack {
            Card()
        }

        // When
        // Assert
        XCTAssertEqual(sut.count, 1)
    }

    func test_CardStackContainsTwoCards() {
        // Given
        let sut = CardStack {
            Card()
            Card()
        }

        // When
        // Assert
        XCTAssertEqual(sut.count, 2)
    }

    func test_CardStackContainsTwoStringCards() {
        // Given
        // When
        let sut = CardStack {
            "c1"
            "c2"
        }

        // Assert
        XCTAssertEqual(sut.count, 2)
    }

    func test_TopIsNil_IfstackIsEmpty() {
        // Given
        let sut = CardStack()

        // When
        // Assert
        XCTAssertNil(sut.top)
    }

    func test_ReturnFirstCard_IfGettingTop() {
        // Given
        let sut = CardStack {
            Card("c1")
            Card("c2")
        }

        // When
        // Assert
        XCTAssertEqual(sut.top?.id, "c1")
    }
}
