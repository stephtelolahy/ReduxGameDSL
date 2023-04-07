//
//  CardLocationRulesTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//
@testable import Game
import XCTest

final class CardLocationRulesTests: XCTestCase {

    func test_AddCardWhenEmpty() {
        // Given
        var sut = CardLocation()

        // When
        sut.add("c1")

        // Assert
        XCTAssertEqual(sut.cards, ["c1"])
    }

    func test_AddCardWhenNotEmpty() {
        // Given
        var sut = CardLocation {
            "c1"
        }

        // When
        sut.add("c2")

        // Assert
        XCTAssertEqual(sut.cards, ["c1", "c2"])
    }

    func test_SearchById() {
        // Given
        let sut = CardLocation {
            "c1"
            "c2"
        }

        // When
        // Assert
        XCTAssertFalse(sut.contains("c3"))
        XCTAssertTrue(sut.contains("c1"))
        XCTAssertTrue(sut.contains("c2"))
    }

    func test_RemoveById() throws {
        // Given
        var sut = CardLocation {
            "c1"
            "c2"
        }

        // When
        try sut.remove("c1")

        // Assert
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.cards, ["c2"])
    }
}
