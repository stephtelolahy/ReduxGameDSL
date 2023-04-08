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
        // When
        let sut = CardStack()

        // Then
        XCTAssertEqual(sut.count, 0)
    }

    func test_CardStackContainsOneCard() {
        // Given
        // When
        let sut = CardStack {
            "c1"
        }

        // Then
        XCTAssertEqual(sut.count, 1)
    }

    func test_CardStackContainsTwoCards() {
        // Given
        // When
        let sut = CardStack {
            "c1"
            "c2"
        }

        // Then
        XCTAssertEqual(sut.count, 2)
    }

    func test_TopIsNil_IfstackIsEmpty() {
        // Given
        // When
        let sut = CardStack()

        // Then
        XCTAssertNil(sut.top)
    }

    func test_ReturnFirstCard_IfGettingTop() {
        // Given
        // When
        let sut = CardStack {
            "c1"
            "c2"
        }

        // Then
        XCTAssertEqual(sut.top, "c1")
    }
}
