//
//  PlayerInPlayTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerInPlayTests: XCTestCase {

    func test_InitialInPlayIsEmpty() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.inPlay.count, 0)
    }

    func test_GetHand() {
        // Given
        // When
        let sut = Player {
            InPlay {
                "c1"
                "c2"
            }
        }

        // Then
        XCTAssertEqual(sut.inPlay.cards, ["c1", "c2"])
    }
}
