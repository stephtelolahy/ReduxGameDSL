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
    // swiftlint:disable:next function_body_length
    override func spec() {
        var state: GameState!

        describe("playing Duel") {
            beforeEach {
                state = createGame {
                    Player("p1") {
                        Hand {
                            .duel
                            "bang-1"
                        }
                    }
                    Player("p2") {
                        Hand {
                            "bang-2"
                        }
                    }
                    Player("p3")
                    Player("p4")
                }
            }

            context("without target") {
                it("should ask to select target") {
                    // When
                    let action = GameAction.play(actor: "p1", card: .duel)
                    let result = self.awaitAction(action, choices: ["p4", .pass], state: state)

                    // Then
                    expect(result) == [
                        .success(.chooseOne(chooser: "p1", options: [
                            "p2": .play(actor: "p1", card: .duel, target: "p2"),
                            "p3": .play(actor: "p1", card: .duel, target: "p3"),
                            "p4": .play(actor: "p1", card: .duel, target: "p4")
                        ])),
                        .success(.play(actor: "p1", card: .duel, target: "p4")),
                        .success(.chooseOne(chooser: "p4", options: [
                            .pass: .damage(player: "p4", value: 1)
                        ])),
                        .success(.damage(player: "p4", value: 1))
                    ]
                }
            }

            context("with target") {
                context("passing") {
                    it("should damage") {
                        // When
                        let action = GameAction.play(actor: "p1", card: .duel, target: "p2")
                        let result = self.awaitAction(action, choices: [.pass], state: state)

                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.chooseOne(chooser: "p2", options: [
                                "bang-2": .groupActions([
                                    .discard(player: "p2", card: "bang-2"),
                                    // swiftlint:disable:next line_length
                                    .resolve(.challengeEffect(challenger: .id("p2"), effect: .discard(.selectHandNamed(.bang)), otherwise: .damage(1)), ctx: EffectContext(actor: "p1", card: .duel, target: "p1"))
                                ]),
                                .pass: .damage(player: "p2", value: 1)
                            ])),
                            .success(.damage(player: "p2", value: 1))
                        ]
                    }
                }

                context("discarding bang") {
                    it("should damage actor") {
                        // When
                        let action = GameAction.play(actor: "p1", card: .duel, target: "p2")
                        let result = self.awaitAction(action, choices: ["bang-2", .pass], state: state)

                        // Then
                        expect(result) == [
                            .success(.play(actor: "p1", card: .duel, target: "p2")),
                            .success(.chooseOne(chooser: "p2", options: [
                                "bang-2": .groupActions([
                                    .discard(player: "p2", card: "bang-2"),
                                    // swiftlint:disable:next line_length
                                    .resolve(.challengeEffect(challenger: .id("p2"), effect: .discard(.selectHandNamed(.bang)), otherwise: .damage(1)), ctx: EffectContext(actor: "p1", card: .duel, target: "p1"))
                                ]),
                                .pass: .damage(player: "p2", value: 1)
                            ])),
                            .success(.discard(player: "p2", card: "bang-2")),
                            .success(.chooseOne(chooser: "p1", options: [
                                "bang-1": .groupActions([
                                    .discard(player: "p1", card: "bang-1"),
                                    // swiftlint:disable:next line_length
                                    .resolve(.challengeEffect(challenger: .id("p1"), effect: .discard(.selectHandNamed(.bang)), otherwise: .damage(1)), ctx: EffectContext(actor: "p1", card: .duel, target: "p2"))
                                ]),
                                .pass: .damage(player: "p1", value: 1)
                            ])),
                            .success(.damage(player: "p1", value: 1))
                        ]
                    }
                }
            }
        }
    }
}
