//
//  SerializingCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 28/03/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class SerializingCardSpec: QuickSpec {
    override func spec() {
        describe("serializing card") {
            context("json with all fields") {
                it("should set all fields") {
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
                    expect(sut.name) == "c1"
                }
            }
        }
    }
}
