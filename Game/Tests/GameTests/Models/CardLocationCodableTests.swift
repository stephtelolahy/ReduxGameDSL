//
//  CardLocationCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Game
import XCTest

final class CardLocationCodableTests: XCTestCase {

    func test_CardLocationDecoding() throws {
        // Given
        let JSON = """
        {
            "visibility": "p1",
            "cards": [
                "c1",
                "c2"
            ]
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(CardLocation.self, from: jsonData)

        // Assert
        XCTAssertEqual(sut.visibility, "p1")
        XCTAssertEqual(sut.cards, ["c1", "c2"])
    }
}
