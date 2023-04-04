//
//  GameChoosableTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
import Game
import XCTest

final class GameChoosableTests: XCTestCase {

    func test_ChoosableEmpty() {
        // Given
        // When
        let sut = Game()

        // Assert
        XCTAssertEqual(sut.choosable.count, 0)
    }

    func test_ChoosableContainsTwoCards() {
        // Given
        // When
        let sut = Game {
            Choosable {
                "c1"
                "c2"
            }
        }

        // Assert
        XCTAssertEqual(sut.choosable.cards, ["c1", "c2"])
    }
}
