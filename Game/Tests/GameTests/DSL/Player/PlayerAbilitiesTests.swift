//
//  PlayerAbilitiesTests.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import Game
import XCTest

final class PlayerAbilitiesTests: XCTestCase {

    func test_InitialAbilitiesIsEmpty() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.abilities.count, 0)
    }

    func test_GetAbilities() {
        // Given
        let sut = Player {
            Abilities {
                "a1"
                "a2"
            }
        }

        // When
        // Assert
        XCTAssertEqual(sut.abilities, ["a1", "a2"])
    }
}
