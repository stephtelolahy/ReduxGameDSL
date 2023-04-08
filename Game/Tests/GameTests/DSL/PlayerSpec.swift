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
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("a Player") {
            var sut: Player!
            context("by default") {
                beforeEach {
                    sut = Player()
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
                    expect(sut.maxHealth) == 2
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
        }
    }
}
