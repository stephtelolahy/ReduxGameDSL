//
//  GameCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import XCTest

final class GameCodableTests: XCTestCase {

    func test_DecodingGame() throws {
        // Given
        let JSON = """
        {
            "_isOver": true,
            "_players": [
                {
                    "_id": "p1"
                },
                {
                    "_id": "p2"
                }
            ],
            "_turn": "p1",
            "_deck": {
                "_cards": [
                    {
                        "_id": "c1"
                    }
                ]
            },
            "_discard": {
                "_cards": [
                    {
                        "_id": "c1"
                    }
                ]
            },
            "_store": {
                "_cards": [
                    {
                        "_id": "c3"
                    }
                ]
            }
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(Game.self, from: jsonData)

        // Assert
        XCTAssertTrue(sut.isOver)
        XCTAssertEqual(sut.players.map(\.id), ["p1", "p2"])
        XCTAssertEqual(sut.turn, "p1")
        XCTAssertEqual(sut.deck.count, 1)
        XCTAssertEqual(sut.discard.count, 1)
        XCTAssertEqual(sut.choosable.count, 1)
    }
}
