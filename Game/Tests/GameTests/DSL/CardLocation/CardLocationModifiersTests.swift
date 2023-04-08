//
//  CardLocationModifiersTests.swift
//
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class CardLocationModifiersTests: XCTestCase {

    func test_CardsCountIsZero_WhenInitialized() {
        // Given
        // When
        let sut = CardLocation()

        // Then
        XCTAssertEqual(sut.count, 0)
    }

    func test_CardsCountIsOne_WhenInitializedWithOneCard() {
        // Given
        // When
        let sut = CardLocation {
            "c1"
        }

        // Then
        XCTAssertEqual(sut.count, 1)
    }

    func test_CardsContent() {
        // Given
        // When
        let sut = CardLocation {
            "c1"
            "c2"
            "c3"
        }

        // Then
        XCTAssertEqual(sut.cards, ["c1", "c2", "c3"])
    }

    func test_VisibilityIsPublic_ByDefault() {
        // Given
        // When
        let sut = CardLocation()

        // Then
        XCTAssertNil(sut.visibility)
    }

    func test_VisibilityIsRestricted_AtInit() {
        // Given
        // When
        let sut = CardLocation(visibility: "p1")

        // Then
        XCTAssertEqual(sut.visibility, "p1")
    }
}
