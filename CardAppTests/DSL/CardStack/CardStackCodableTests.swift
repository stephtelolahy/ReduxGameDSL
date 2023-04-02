//
//  CardStackCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import XCTest

final class CardStackCodableTests: XCTestCase {

    func test_CardStackDecoding() throws {
        // Given
        let JSON = """
        {
            "cards": [
                {
                    "id": "c1",
                    "name": ""
                },
                {
                    "id": "c2",
                    "name": ""
                }
            ]
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(CardStack.self, from: jsonData)

        // Assert
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut.top?.id, "c1")
    }
}
