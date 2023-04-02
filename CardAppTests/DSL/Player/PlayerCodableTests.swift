//
//  PlayerCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import XCTest

final class PlayerCodableTests: XCTestCase {

    func test_DecodingPlayer() throws {
        // Given
        let JSON = """
        {
            "id": "p1",
            "name": "n1",
            "maxHealth": 4,
            "health": 2,
            "handLimit": 2,
            "weapon": 3,
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
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(Player.self, from: jsonData)

        // Assert
        XCTAssertEqual(sut.id, "p1")
        XCTAssertEqual(sut.name, "n1")
        XCTAssertEqual(sut.maxHealth, 4)
        XCTAssertEqual(sut.health, 2)
        XCTAssertEqual(sut.handLimit, 2)
        XCTAssertEqual(sut.weapon, 3)
        XCTAssertEqual(sut.mustang, 0)
        XCTAssertEqual(sut.scope, 1)
    }
}
