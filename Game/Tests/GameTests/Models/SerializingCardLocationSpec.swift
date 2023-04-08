//
//  CardLocationCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class SerializingCardLocationSpec: QuickSpec {
    override func spec() {
        describe("serializing card location") {
            context("json with all fields") {
                it("should set all fields") {
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
                    
                    // Then
                    expect(sut.visibility) == "p1"
                    expect(sut.cards) == ["c1", "c2"]
                }
            }
        }
    }
}
