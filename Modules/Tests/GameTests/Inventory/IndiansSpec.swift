//
//  IndiansSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game

final class IndiansSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing Indians") {
            context("three players") {
                it("should allow each player to counter or pass") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .indians
                            }
                        }
                        Player("p2") {
                            Hand {
                                .bang
                            }
                        }

                        Player("p3")
                    }
                    let sut = createGameStore(initial: state)

                    // When
                    var action = GameAction.play(actor: "p1", card: .indians)
                    var result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [.success(.play(actor: "p1", card: .indians))]
                    let ctx2 = EffectContext(actor: "p1", card: .indians, target: "p2")
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                        .bang: .apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2),
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctx2)
                    ])

                    // When p2 counter
                    action = .apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2)
                    result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [
                        .success(.apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2))
                    ]
                    let ctx3 = EffectContext(actor: "p1", card: .indians, target: "p3")
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p3", options: [
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctx3)
                    ])

                    // When p3 pass
                    action = .apply(.damage(1, player: .target), ctx: ctx3)
                    result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [
                        .success(.apply(.damage(1, player: .id("p3")), ctx: ctx3))
                    ]
                    expect(sut.state.chooseOne) == nil
                }
            }

            context("two players") {
                it("should allow each player to counter") {
                    // Given
                    let state = GameState {
                        Player("p1") {
                            Hand {
                                .indians
                            }
                        }
                        Player("p2") {
                            Hand {
                                .bang
                            }
                        }
                    }
                    let sut = createGameStore(initial: state)

                    // When
                    var action = GameAction.play(actor: "p1", card: .indians)
                    var result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [.success(.play(actor: "p1", card: .indians))]
                    let ctx2 = EffectContext(actor: "p1", card: .indians, target: "p2")
                    expect(sut.state.chooseOne) == ChooseOne(chooser: "p2", options: [
                        .bang: .apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2),
                        Label.pass: .apply(.damage(1, player: .target), ctx: ctx2)
                    ])

                    // When p2 counter
                    action = .apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2)
                    result = self.awaitAction(action, store: sut)

                    // Then
                    expect(result) == [
                        .success(.apply(.discard(player: .id("p2"), card: .id(.bang)), ctx: ctx2))
                    ]
                    expect(sut.state.chooseOne) == nil
                }
            }
        }
    }
}