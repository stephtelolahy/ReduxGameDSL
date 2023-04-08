//
//  PlayerWeaponTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import Game
import XCTest

final class PlayerWeaponTests: XCTestCase {

    func test_InitialWeaponIsOne() {
        // Given
        // When
        let sut = Player()

        // Then
        XCTAssertEqual(sut.weapon, 1)
    }

    func test_GetWeapon() {
        // Given
        // When
        let sut = Player().weapon(4)

        // Then
        XCTAssertEqual(sut.weapon, 4)
    }
}
