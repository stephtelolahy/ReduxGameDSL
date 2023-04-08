//
//  CardStackSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Quick
import Nimble
import Game

final class CardStackSpec: QuickSpec {
    override func spec() {
        describe("a card stack") {
            var sut: CardStack!
            context("by default") {
                beforeEach {
                    sut = CardStack()
                }

                it("should be empty") {
                    expect(sut.count) == 0
                }

                it("should not have top") {
                    expect(sut.top) == nil
                }
            }

            context("initialized with cards") {
                it("should have correct count") {
                    // Given
                    // When
                    let sut = CardStack {
                        "c1"
                        "c2"
                    }

                    // Then
                    expect(sut.count) == 2
                }

                it("should return first card as top") {
                    // Given
                    // When
                    let sut = CardStack {
                        "c1"
                        "c2"
                    }

                    // Then
                    expect(sut.top) == "c1"
                }
            }
        }
    }
}
