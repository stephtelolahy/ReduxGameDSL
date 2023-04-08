//
//  CardStackSpec.swift
//  
//
//  Created by Hugues Telolahy on 08/04/2023.
//

@testable import Game
import Quick
import Nimble

final class CardStackSpec: QuickSpec {
    override func spec() {
        describe("popping") {
            context("non empty stack") {
                it("should remove top card") {
                    // Given
                    var sut = CardStack {
                        "c1"
                        "c2"
                    }

                    // When
                    let card = try sut.pop()

                    // Then
                    expect(card) == "c1"
                    expect(sut.top) == "c2"
                    expect(sut.count) == 1
                }
            }

            context("empty stack") {
                it("should throw error") {
                    // Given
                    var sut = CardStack()

                    // When
                    // Then
                    expect { try sut.pop() }
                        .to(throwError(GameError.stackIsEmpty))
                }
            }
        }

        describe("pushing") {
            context("empty stack") {
                it("should push on top") {
                    // Given
                    var sut = CardStack()

                    // When
                    sut.push("c1")

                    // Then
                    expect(sut.top) == "c1"
                    expect(sut.count) == 1
                }
            }

            context("non empty stack") {
                it("should push on top") {
                    // Given
                    var sut = CardStack {
                        "c2"
                    }

                    // When
                    sut.push("c1")

                    // Then
                    expect(sut.top) == "c1"
                    expect(sut.count) == 2
                }
            }
        }
    }
}
