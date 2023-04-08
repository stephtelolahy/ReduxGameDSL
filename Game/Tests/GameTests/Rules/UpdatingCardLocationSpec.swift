//
//  UpdatingCardLocationSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

@testable import Game
import Quick
import Nimble

final class UpdatingCardLocationSpec: QuickSpec {
    override func spec() {
        describe("adding") {
            context("location empty") {
                it("should set first card") {
                    // Given
                    var sut = CardLocation()

                    // When
                    sut.add("c1")

                    // Then
                    expect(sut.cards) == ["c1"]
                }
            }

            context("location not empty") {
                it("should append last card") {
                    // Given
                    var sut = CardLocation {
                        "c1"
                        "c2"
                    }

                    // When
                    sut.add("c3")

                    // Then
                    expect(sut.cards) == ["c1", "c2", "c3"]
                }
            }
        }

        describe("searching") {
            context("an existing card") {
                it("should be found") {
                    // Given
                    let sut = CardLocation {
                        "c1"
                        "c2"
                    }

                    // When
                    // Then
                    expect(sut.contains("c1")) == true
                    expect(sut.contains("c2")) == true
                }
            }

            context("missing card") {
                it("should not be found") {
                    // Given
                    let sut = CardLocation {
                        "c1"
                        "c2"
                    }

                    // When
                    // Then
                    expect(sut.contains("c3")) == false
                }
            }
        }

        describe("removing") {
            context("an existing card") {
                it("should remove") {
                    // Given
                    var sut = CardLocation {
                        "c1"
                        "c2"
                    }

                    // When
                    try sut.remove("c1")

                    // Then
                    expect(sut.cards) == ["c2"]
                }
            }

            context("missing card") {
                it("should throw error") {
                    // Given
                    var sut = CardLocation()

                    // When
                    // Then
                    expect { try sut.remove("c1") }
                        .to(throwError(GameError.missingCard("c1")))
                }
            }
        }
    }
}
