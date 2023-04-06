//
//  GameEventTests.swift
//
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import Game
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
            LastEvent(.doAction(.play))
        }

        // When
        // Assert
        XCTAssertEqual(sut.event, .doAction(.play))
    }
}

struct SomeError: Error, Equatable {}
