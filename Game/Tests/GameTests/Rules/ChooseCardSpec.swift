//
//  ChooseCardSpec.swift
//  
//
//  Created by Hugues Telolahy on 11/04/2023.
//

@testable import Game
import Quick
import Nimble

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
                        let action = GameAction.apply(.chooseCard(player: .id("p1"), card: .selectChoosable), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.completedAction) == nil
                        expect(result.chooseOne) == [
                            "c1": .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx),
                            "c2": .apply(.chooseCard(player: .id("p1"), card: .id("c2")), ctx: ctx)
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
                        let action = GameAction.apply(.chooseCard(player: .id("p1"), card: .selectChoosable), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

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

                        let action = GameAction.apply(.chooseCard(player: .id("p1"), card: .selectChoosable), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.thrownError) == GameError.choosableIsEmpty
                    }
                }
            }

            context("specified") {
                context("multiple cards remaining") {
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
                        let action = GameAction.apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.completedAction) == action
                        expect(result.player("p1").hand.cards) == ["c1"]
                        expect(result.choosable?.cards) == ["c2"]
                    }
                }

                context("last card") {
                    it("should draw that card and delete card location") {
                        // Given
                        let state = GameState {
                            Player("p1")
                            Choosable {
                                "c1"
                            }
                        }

                        // When
                        let action = GameAction.apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.completedAction) == action
                        expect(result.player("p1").hand.cards) == ["c1"]
                        expect(result.choosable) == nil
                    }
                }
            }
        }
    }
}
