//
//  DuelSpec.swift
//  
//
//  Created by Hugues Telolahy on 26/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class DuelSpec: QuickSpec {
    override func spec() {
        describe("playing Duel") {

            xcontext("without target") {
                it("should ask to select target") {
                }
            }

            context("with target") {
                context("passing") {
                    it("should damage") {
                        // Given
                        let state = createGame {
                            Player("p1") {
                                Hand {
                                    .duel
                                }
                            }
                            Player("p2")
                        }
                        let sut = createGameStore(initial: state)

                        // When
                        var action = GameAction.play(actor: "p1", card: .duel, target: "p2")
                        var result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [.success(.play(actor: "p1", card: .duel, target: "p2"))]
                        let ctx2 = EffectContext(actor: "p1", card: .duel, target: "p2")
                        expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                            .pass: .damage(1, player: .target, ctx: ctx2)
                        ])

                        // When p2 passes
                        action = .damage(1, player: .target, ctx: ctx2)
                        result = self.awaitAction(action, store: sut)

                        // Then
                        expect(result) == [
                            .success(.damage(1, player: .id("p2")))
                        ]
                        expect(sut.state.chooseOne) == nil
                    }
                }

                xcontext("discarding bang") {
                    it("should damage actor") {
                        // Given
                        // When
                        // Then
                    }
                }

                xcontext("target and actor discarding bang") {
                    it("should damage target") {
                        // Given
                        // When
                        // Then
                    }
                }
            }
        }
    }
}
