//
//  IndiansSpec.swift
//  
//
//  Created by Hugues Telolahy on 22/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class IndiansSpec: QuickSpec {
    override func spec() {
        describe("playing Indians") {
            context("three players") {
                it("should allow each player to counter or pass") {
                    // Given
                    let state = createGame {
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

                    // When
                    let result = self.awaitSequence(action: .play(actor: "p1", card: .indians),
                                                    choices: [.bang, .pass],
                                                    state: state)

                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .indians)),
                        .success(.discard(player: "p2", card: .bang)),
                        .success(.damage(1, player: "p3"))
                    ]
                }
            }

            context("two players") {
                it("should allow each player to counter") {
                    // Given
                    let state = createGame {
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

                    // When
                    let result = self.awaitSequence(action: .play(actor: "p1", card: .indians),
                                                    choices: [.bang],
                                                    state: state)

                    // Then
                    expect(result) == [
                        .success(.play(actor: "p1", card: .indians)),
                        .success(.discard(player: "p2", card: .bang))
                    ]
                }
            }
        }
    }
}
