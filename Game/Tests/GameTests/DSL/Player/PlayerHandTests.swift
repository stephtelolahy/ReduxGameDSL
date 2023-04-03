//
//  PlayerHandTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerHandTests: XCTestCase {

    func test_InitialHandIsEmpty() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.hand.count, 0)
    }

    func test_GetHand() {
        // Given
        let sut = Player {
            Hand {
                "c1"
                "c2"
            }
        }

        // When
        // Assert
        XCTAssertEqual(sut.hand.cards.map(\.id), ["c1", "c2"])
    }
}
