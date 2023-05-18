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
                            Arena {
                                "c1"
                                "c2"
                            }
                        }

                        // When
                        let action = CardEffect.chooseCard(player: .id("p1"), card: .selectArena).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.queue.first) == .chooseOne(chooser: "p1", options: [
                            "c1": .chooseCard(player: "p1", card: "c1"),
                            "c2": .chooseCard(player: "p1", card: "c2")
                        ])
                    }
                }

                context("single card remaining") {
                    it("should not ask a choice") {
                        // Given
                        let state = GameState {
                            Arena {
                                "c1"
                            }
                        }

                        // When
                        let action = CardEffect.chooseCard(player: .id("p1"), card: .selectArena).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.event) == nil
                        expect(result.queue) == [
                            GameAction.chooseCard(player: "p1", card: "c1")
                        ]
                    }
                }

                context("no card available") {
                    it("should throw error") {
                        // Given
                        let state = GameState()

                        // When

                        let action = CardEffect.chooseCard(player: .id("p1"), card: .selectArena).withCtx(ctx)
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.error) == .noCard(.selectArena)
                    }
                }
            }

            context("specified") {
                context("multiple cards remaining") {
                    it("should draw that card") {
                        // Given
                        let state = GameState {
                            Player("p1")
                            Arena {
                                "c1"
                                "c2"
                            }
                        }

                        // When
                        let action = GameAction.chooseCard(player: "p1", card: "c1")
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.event) == .chooseCard(player: "p1", card: "c1")
                        expect(result.player("p1").hand.cards) == ["c1"]
                        expect(result.arena?.cards) == ["c2"]
                    }
                }

                context("last card") {
                    it("should draw that card and delete card location") {
                        // Given
                        let state = GameState {
                            Player("p1")
                            Arena {
                                "c1"
                            }
                        }

                        // When
                        let action = GameAction.chooseCard(player: "p1", card: "c1")
                        let result = sut.reduce(state: state, action: action)

                        // Then
                        expect(result.event) == .chooseCard(player: "p1", card: "c1")
                        expect(result.player("p1").hand.cards) == ["c1"]
                        expect(result.arena) == nil
                    }
                }
            }
        }
    }
}
