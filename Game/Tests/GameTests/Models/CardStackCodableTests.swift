//
//  CardStackCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Game
import XCTest

final class CardStackCodableTests: XCTestCase {

    func test_CardStackDecoding() throws {
        // Given
        let JSON = """
        {
            "cards": [
                "c1",
                "c2"
            ]
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(CardStack.self, from: jsonData)

        // Assert
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut.top, "c1")
    }
}
