//
//  PlayerSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//
import Game
import Quick
import Nimble

final class PlayerSpec: QuickSpec {
    override func spec() {
        describe("a Player") {
            var sut: Player!
            context("default") {
                beforeEach {
                    sut = Player()
                }

                it("should have no abilities") {
                    expect(sut.abilities).to(beEmpty())
                }

                it("should have hand limit = 0") {
                    expect(sut.handLimit) == 0
                }

                it("should have empty hand") {
                    expect(sut.hand.cards).to(beEmpty())
                }
            }

            context("modified") {
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

                it("should have hand limit") {
                    // Given
                    // When
                    let sut = Player().handLimit(10)

                    // Then
                    expect(sut.handLimit) == 10
                }

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
        }
    }
}
