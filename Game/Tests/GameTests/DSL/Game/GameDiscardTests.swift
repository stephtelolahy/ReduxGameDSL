//
//  GameDiscardTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GameDiscardTests: XCTestCase {

    func test_DiscardPileIsEmpty() {
        // Given
        // When
        let sut = Game()

        // Assert
        XCTAssertEqual(sut.discard.count, 0)
    }

    func test_DeckContainsTwoCards() {
        // Given
        // When
        let sut = Game {
            DiscardPile {
                Card("c1")
                Card("c2")
            }
        }

        // Assert
        XCTAssertEqual(sut.discard.count, 2)
        XCTAssertEqual(sut.discard.top?.id, "c1")
    }
}
