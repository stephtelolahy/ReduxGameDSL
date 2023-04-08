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
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.hand.count, 0)
    }

    func test_GetHand() {
        // Given
        // When
        let sut = Player {
            Hand {
                "c1"
                "c2"
            }
        }

        // Then
        XCTAssertEqual(sut.hand.cards, ["c1", "c2"])
    }
}
