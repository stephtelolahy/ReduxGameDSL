//
//  CardStackRulesTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//
@testable import Game
import XCTest

final class CardStackRulesTests: XCTestCase {

    func test_ReturnFirstCard_IfPopStack() {
        // Given
        var sut = CardStack {
            "c1"
            "c2"
        }

        // When
        let card = sut.pop()

        // Then
        XCTAssertEqual(card, "c1")
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.top, "c2")
    }

    func test_PushACard_OnEmptyStack() {
        // Given
        var sut = CardStack()

        // When
        sut.push("c1")

        // Then
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.top, "c1")
    }

    func test_PushACard_OnNonEmptyStack() {
        // Given
        var sut = CardStack {
            "c2"
        }

        // When
        sut.push("c1")

        // Then
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut.top, "c1")
    }

    func test_PushAndPop() {
        // Given
        var sut = CardStack()

        // When
        sut.push("c1")
        sut.push("c2")
        sut.push("c3")
        sut.pop()

        // Then
        XCTAssertEqual(sut.top, "c2")
    }
}
