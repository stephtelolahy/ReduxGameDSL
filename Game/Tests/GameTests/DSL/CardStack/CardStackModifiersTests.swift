//
//  CardStackModifiersTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
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
            "c1"
        }

        // When
        // Assert
        XCTAssertEqual(sut.count, 1)
    }

    func test_CardStackContainsTwoCards() {
        // Given
        let sut = CardStack {
            "c1"
            "c2"
        }

        // When
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
            "c1"
            "c2"
        }

        // When
        // Assert
        XCTAssertEqual(sut.top, "c1")
    }
}
