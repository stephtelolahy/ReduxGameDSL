//
//  PlayerSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import Game
import Quick
import Nimble
import Foundation

final class PlayerSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("a player") {
            var sut: Player!
            context("by default") {
                beforeEach {
                    sut = Player()
                }

                it("should have default identifier") {
                    expect(sut.id).toNot(beEmpty())
                }

                it("should have empty name") {
                    expect(sut.name).to(beEmpty())
                }

                it("should have no abilities") {
                    expect(sut.abilities).to(beEmpty())
                }

                it("should not have hand limit") {
                    expect(sut.handLimit) == nil
                }

                it("should have empty hand") {
                    expect(sut.hand.cards).to(beEmpty())
                }

                it("should have health == 0") {
                    expect(sut.health) == 0
                }

                it("should have max health == 0") {
                    expect(sut.maxHealth) == 0
                }

                it("should have empty inPlay") {
                    expect(sut.inPlay.cards).to(beEmpty())
                }

                it("should have mustang == 0") {
                    expect(sut.attributes[.mustang]) == nil
                }

                it("should have scope == 0") {
                    expect(sut.attributes[.scope]) == nil
                }

                it("should have weapon == 1") {
                    expect(sut.weapon) == 1
                }
            }

            context("initialized with identifier") {
                it("should have identifier") {
                    // Given
                    // When
                    let sut = Player("p1")

                    // Then
                    expect(sut.id) == "p1"
                }
            }

            context("initialized with abilities") {
                it("should have abilities") {
                    // Given
                    // When
                    let sut = Player {
                        Abilities {
                            "a1"
                            "a2"
                        }
                    }

                    // Then
                    expect(sut.abilities) == ["a1", "a2"]
                }
            }

            context("modified name") {
                it("should have name") {
                    // Given
                    // When
                    let sut = Player().name("p1")

                    // Then
                    expect(sut.name) == "p1"
                }
            }

            context("modified hand limit") {
                it("should have hand limit") {
                    // Given
                    // When
                    let sut = Player().handLimit(10)

                    // Then
                    expect(sut.handLimit) == 10
                }
            }

            context("initialized with hand") {
                it("should have hand cards") {
                    // Given
                    // When
                    let sut = Player {
                        Hand {
                            "c1"
                            "c2"
                        }
                    }

                    // Then
                    expect(sut.hand.cards) == ["c1", "c2"]
                }
            }

            context("modified health") {
                it("should have health") {
                    // Given
                    // When
                    let sut = Player().health(2)

                    // Then
                    expect(sut.health) == 2
                }
            }

            context("modified max health") {
                it("should have max health") {
                    // Given
                    // When
                    let sut = Player().maxHealth(3)

                    // Then
                    expect(sut.maxHealth) == 3
                }
            }

            context("initialized with inPlay") {
                it("should have inPlay cards") {
                    // Given
                    // When
                    let sut = Player {
                        InPlay {
                            "c1"
                            "c2"
                        }
                    }

                    // Then
                    expect(sut.inPlay.cards) == ["c1", "c2"]
                }
            }

            context("modified attribute") {
                it("should have that attribute") {
                    // Given
                    // When
                    let sut = Player().attribute(.mustang, value: 1)

                    // Then
                    expect(sut.attributes[.mustang]) == 1
                }
            }

            context("modified weapon") {
                it("should have weapon") {
                    // Given
                    // When
                    let sut = Player().weapon(4)

                    // Then
                    expect(sut.weapon) == 4
                }
            }

            it("should be serializable") {
                // Given
                let JSON = """
                {
                    "id": "p1",
                    "name": "n1",
                    "maxHealth": 4,
                    "health": 2,
                    "handLimit": 2,
                    "weapon": 3,
                    "starTurnCards": 2,
                    "abilities": [],
                    "attributes": {
                        "mustang": 0,
                        "scope": 1
                    },
                    "hand": {
                        "visibility": "p1",
                        "cards": []
                    },
                    "inPlay": {
                        "cards": []
                    }
                }
                """
                // swiftlint:disable:next: force_unwrapping
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
                expect(sut.attributes[.mustang]) == 0
                expect(sut.attributes[.scope]) == 1
            }
        }
    }
}
