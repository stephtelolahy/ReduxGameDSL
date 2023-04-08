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
        let sut = GameState()

        // Then
        XCTAssertEqual(sut.choosable.count, 0)
    }

    func test_ChoosableContainsTwoCards() {
        // Given
        // When
        let sut = GameState {
            Choosable {
                "c1"
                "c2"
            }
        }

        // Then
        XCTAssertEqual(sut.choosable.cards, ["c1", "c2"])
    }
}
