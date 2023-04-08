//
//  CardCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Game
import XCTest

final class CardCodableTests: XCTestCase {

    func test_DecodeCards() throws {
        // Given
        let JSON = """
        {
            "name": "c1",
            "actions": []
        }
        """
        let jsonData = JSON.data(using: .utf8)!

        // When
        let sut = try JSONDecoder().decode(Card.self, from: jsonData)

        // Then
        XCTAssertEqual(sut.name, "c1")
    }
}
