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
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.inPlay.count, 0)
    }

    func test_GetHand() {
        // Given
        let sut = Player {
            InPlay {
                "c1"
                "c2"
            }
        }

        // When
        // Assert
        XCTAssertEqual(sut.inPlay.cards, ["c1", "c2"])
    }
}
