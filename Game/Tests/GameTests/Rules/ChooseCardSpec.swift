//
//  ChooseCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

import Quick
import Nimble
import Game

final class ChooseCardSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let sut = GameReducer()
        let ctx = EffectContext(actor: "p1", card: "cx")
        describe("choose a card") {
            context("unspecified") {
                context("multiple cards available") {
                    it("should ask a choice") {
                        // Given
                        let state = GameState {
                            Choosable {
                                "c1"
                                "c2"
                            }
                        }

                        // When
                        let effect = CardEffect.chooseCard(player: .id("p1"), card: .selectChoosable)
                        let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                        // Then
                        expect(result.completedAction) == nil
                        expect(result.chooseOne) == [
                            .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx),
                            .apply(.chooseCard(player: .id("p1"), card: .id("c2")), ctx: ctx)
                        ]
                    }
                }

                context("single card remaining") {
                    it("should not ask a choice") {
                        // Given
                        let state = GameState {
                            Choosable {
                                "c1"
                            }
                        }

                        // When
                        let effect = CardEffect.chooseCard(player: .id("p1"), card: .selectChoosable)
                        let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                        // Then
                        expect(result.completedAction) == nil
                        expect(result.queue) == [
                            .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx)
                        ]
                    }
                }

                context("no card available") {
                    it("should throw error") {
                        // Given
                        let state = GameState()

                        // When

                        let effect = CardEffect.chooseCard(player: .id("p1"), card: .selectChoosable)
                        let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                        // Then
                        expect(result.thrownError) == GameError.noChoosableCard
                    }
                }
            }

            context("specified id") {
                it("should draw that card") {
                    // Given
                    let state = GameState {
                        Player("p1")
                        Choosable {
                            "c1"
                            "c2"
                        }
                    }

                    // When
                    let effect = CardEffect.chooseCard(player: .id("p1"), card: .id("c1"))
                    let result = sut.reduce(state: state, action: .apply(effect, ctx: ctx))

                    // Then
                    expect(result.completedAction) == .apply(effect, ctx: ctx)
                    expect(result.player("p1").hand.cards) == ["c1"]
                    expect(result.choosable?.cards) == ["c2"]
                    expect(result.queue).to(beEmpty())
                    expect(result.chooseOne) == nil
                }
            }
        }
    }
}
