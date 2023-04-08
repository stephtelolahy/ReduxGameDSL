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
        describe("card popping") {
            context("valid") {
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
                    expect(sut.count) == 1
                    expect(sut.top) == "c2"
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
    }
}
