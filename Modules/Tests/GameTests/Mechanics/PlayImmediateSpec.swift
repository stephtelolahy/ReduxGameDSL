//
//  PlayImmediateSpec.swift
//
//
//  Created by Hugues Telolahy on 08/04/2023.
//

import Game
import Quick
import Nimble

final class PlayImmediateSpec: QuickSpec {
    override func spec() {
        let sut = GameReducer()
        var result: GameState!

        describe("playing immediate card") {
            beforeEach {
                // Given
                let state = GameState {
                    Player("p1") {
                        Hand {
                            .beer
                        }
                    }
                    .attribute(.health, 1)
                    .attribute(.maxHealth, 3)
                }
                .cardRef(CardList.all)

                // When
                let action = GameAction.playImmediate(actor: "p1", card: .beer)
                result = sut.reduce(state: state, action: action)
            }

            it("should discard immediately") {
                // Then
                expect(result.player("p1").hand.cards).to(beEmpty())
                expect(result.discard.top) == .beer
            }

            it("should emit event") {
                // Then
                expect(result.event) == .playImmediate(actor: "p1", card: .beer)
            }

            it("should increment counter") {
                // Then
                expect(result.playCounter[.beer]) == 1
            }

            it("should queue side effects") {
                // Then
                let ctx: EffectContext = [.actor: "p1", .card: .beer]
                expect(result.queue) == [
                    .resolve(.heal(1).target(.actor), ctx: ctx)
                ]
            }
        }
    }
}