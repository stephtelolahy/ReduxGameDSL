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
            context("being initialized") {
                beforeEach {
                    sut = Player()
                }

                it("should have no abilities") {
                    expect(sut.abilities).to(beEmpty())
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
            }
        }
    }
}
