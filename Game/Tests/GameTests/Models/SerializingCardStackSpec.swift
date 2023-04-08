//
//  SerializingCardStackSpec.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class SerializingCardStackSpec: QuickSpec {
    override func spec() {
        describe("serializing card stack") {
            context("json with all fields") {
                it("should set all fields") {
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

                    // Then
                    expect(sut.count) == 2
                    expect(sut.top) == "c1"
                }
            }
        }
    }
}
