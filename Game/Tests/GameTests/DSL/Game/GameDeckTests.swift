//
//  GameDeckTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GameDeckTests: XCTestCase {

    func test_DeckEmpty() {
        // Given
        // When
        let sut = Game()

        // Assert
        XCTAssertEqual(sut.deck.count, 0)
    }

    func test_DeckContainsOneCard() {
        // Given
        // When
        let sut = Game {
            Deck {
                Card()
            }
        }

        // Assert
        XCTAssertEqual(sut.deck.count, 1)
    }

    func test_DeckContainsTwoCards() {
        // Given
        // When
        let sut = Game {
            Deck {
                Card("c1")
                Card("c2")
            }
        }

        // Assert
        XCTAssertEqual(sut.deck.count, 2)
        XCTAssertEqual(sut.deck.top?.id, "c1")
    }
}
