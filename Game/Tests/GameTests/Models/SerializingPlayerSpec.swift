//
//  SerializingPlayerSpec.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class SerializingPlayerSpec: QuickSpec {
    override func spec() {
        describe("serializing player") {
            context("json with all fields") {
                it("should set all fields") {
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

                    // Then
                    expect(sut.id) == "p1"
                    expect(sut.name) == "n1"
                    expect(sut.maxHealth) == 4
                    expect(sut.health) == 2
                    expect(sut.handLimit) == 2
                    expect(sut.weapon) == 3
                    expect(sut.mustang) == 0
                    expect(sut.scope) == 1
                }
            }
        }
    }
}
