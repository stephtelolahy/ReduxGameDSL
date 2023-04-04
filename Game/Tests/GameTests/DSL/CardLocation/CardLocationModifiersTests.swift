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
        let sut = CardLocation()

        // When
        // Assert
        XCTAssertEqual(sut.count, 0)
    }

    func test_CardsCountIsOne_WhenInitializedWithOneCard() {
        // Given
        let sut = CardLocation {
            "c1"
        }

        // When
        // Assert
        XCTAssertEqual(sut.count, 1)
    }

    func test_CardsContent() {
        // Given
        let sut = CardLocation {
            "c1"
            "c2"
            "c3"
        }

        // When
        // Assert
        XCTAssertEqual(sut.cards, ["c1", "c2", "c3"])
    }

    func test_VisibilityIsPublic_ByDefault() {
        // Given
        let sut = CardLocation()

        // When
        // Assert
        XCTAssertNil(sut.visibility)
    }

    func test_VisibilityIsRestricted_AtInit() {
        // Given
        let sut = CardLocation(visibility: "p1")

        // When
        // Assert
        XCTAssertEqual(sut.visibility, "p1")
    }
}
