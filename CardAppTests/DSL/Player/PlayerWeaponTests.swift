//
//  PlayerWeaponTests.swift
//  
//
//  Created by Hugues Telolahy on 26/03/2023.
//
import XCTest

final class PlayerWeaponTests: XCTestCase {

    func test_InitialWeaponIsOne() {
        // Given
        let sut = Player()

        // When
        // Assert
        XCTAssertEqual(sut.weapon, 1)
    }

    func test_GetWeapon() {
        // Given
        let sut = Player().weapon(4)

        // When
        // Assert
        XCTAssertEqual(sut.weapon, 4)
    }
}
