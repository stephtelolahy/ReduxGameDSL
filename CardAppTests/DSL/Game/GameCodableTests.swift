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
            "isOver": true,
            "players": [
                {
                    "id": "p1",
                    "name": "p1",
                    "maxHealth": 4,
                    "health": 3,
                    "handLimit": 3,
                    "weapon": 1,
                    "mustang": 0,
                    "scope": 1,
                    "abilities": [],
                    "hand": {
                        "visibility": "p1",
                        "cards": []
                    },
                    "inPlay": {
                        "cards": []
                    }
                }
            ],
            "turn": "p1",
            "deck": {
                "cards": [
                    {
                        "id": "c1",
                        "name": "c1"
                    }
                ]
            },
            "discard": {
                "cards": [
                    {
                        "id": "c2",
                        "name": "c2"
                    }
                ]
            },
            "choosable": {
                "cards": []
            }
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(Game.self, from: jsonData)

        // Assert
        XCTAssertTrue(sut.isOver)
        XCTAssertEqual(sut.players.map(\.id), ["p1"])
        XCTAssertEqual(sut.turn, "p1")
        XCTAssertEqual(sut.deck.count, 1)
        XCTAssertEqual(sut.discard.count, 1)
        XCTAssertEqual(sut.choosable.count, 0)
    }
}
