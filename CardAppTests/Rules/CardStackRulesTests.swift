//
//  CardStackRulesTests.swift
//  CardAppTests
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import XCTest

final class CardStackRulesTests: XCTestCase {
    
    func test_ReturnFirstCard_IfPopStack() {
        // Given
        var sut = CardStack {
            Card("c1")
            Card("c2")
        }

        // When
        let card = sut.pop()

        // Assert
        XCTAssertEqual(card.id, "c1")
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.top?.id, "c2")
    }

    func test_PushACard_OnEmptyStack() {
        // Given
        var sut = CardStack()

        // When
        sut.push(Card("c1"))

        // Assert
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.top?.id, "c1")
    }

    func test_PushACard_OnNonEmptyStack() {
        // Given
        var sut = CardStack {
            Card()
        }

        // When
        sut.push(Card("c1"))

        // Assert
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut.top?.id, "c1")
    }

    func test_PushAndPop() {
        // Given
        var sut = CardStack()

        // When
        sut.push(Card("c1"))
        sut.push(Card("c2"))
        sut.push(Card("c3"))
        sut.pop()

        // Assert
        XCTAssertEqual(sut.top?.id, "c2")
    }
}
