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
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.abilities.count, 0)
    }

    func test_GetAbilities() {
        // Given
        // When
        let sut = Player {
            Abilities {
                "a1"
                "a2"
            }
        }

        // Then
        XCTAssertEqual(sut.abilities, ["a1", "a2"])
    }
}
