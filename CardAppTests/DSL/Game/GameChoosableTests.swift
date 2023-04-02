//
//  GameChoosableTests.swift
//  
//
//  Created by Hugues Telolahy on 25/03/2023.
//
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
                Card("c1")
                Card("c2")
            }
        }

        // Assert
        XCTAssertEqual(sut.choosable.cards.map(\.id), ["c1", "c2"])
    }
}
