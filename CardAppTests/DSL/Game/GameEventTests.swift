//
//  GameEventTests.swift
//
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import XCTest

final class GameEventTests: XCTestCase {

    func test_InitialEventIsNil() {
        // Given
        let sut = Game()

        // When
        // Assert
        XCTAssertNil(sut.event)
    }

    func test_GetLastEvent() {
        // Given
        let sut = Game {
            LastEvent(.effect(.draw(player: "p1")))
        }

        // When
        // Assert
        XCTAssertEqual(sut.event, .effect(.draw(player: "p1")))
    }
}

struct SomeError: Error, Equatable {}
