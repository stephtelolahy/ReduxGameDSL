//
//  GameCodableTests.swift
//  
//
//  Created by Hugues Telolahy on 29/03/2023.
//
import Foundation
import Game
import Quick
import Nimble

final class SerializingGameSpec: QuickSpec {
    override func spec() {
        describe("serializing game") {
            context("json with all fields") {
                it("should set all fields") {
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
                                "c1"
                            ]
                        },
                        "discard": {
                            "cards": [
                                "c2"
                            ]
                        }
                    }
                    """
                    let jsonData = JSON.data(using: .utf8)!

                    // When
                    let sut = try JSONDecoder().decode(GameState.self, from: jsonData)

                    // Then
                    expect(sut.isOver) == true
                    expect(sut.players.map(\.id)) == ["p1"]
                    expect(sut.turn) == "p1"
                    expect(sut.deck.count) == 1
                    expect(sut.discard.count) == 1
                    expect(sut.choosable) == nil
                }
            }
        }
    }
}
