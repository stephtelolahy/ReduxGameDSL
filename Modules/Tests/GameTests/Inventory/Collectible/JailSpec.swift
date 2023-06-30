//
//  JailSpec.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 29/06/2023.
//

import Quick
import Nimble
import Game

final class JailSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("playing jail") {
            it("should handicap") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .jail
                        }
                    }
                    Player("p2")
                }
                
                // When
                let action = GameAction.play(.jail, actor: "p1")
                let result = self.awaitAction(action, choices: ["p2"], state: state)
                
                // Then
                expect(result) == [
                    .success(.playEquipment(.barrel, actor: "p1")),
                    .su
                ]
            }
        }
        
        xdescribe("triggering jail") {
            context("flipped card is hearts") {
                it("should scape from jail and start turn normally") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }
                        Player("p2") {
                            InPlay {
                                .barrel
                            }
                        }
                        Deck {
                            "c1-2♥️"
                        }
                    }

                    // When
                    let action = GameAction.playImmediate(.bang, target: "p2", actor: "p1")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.success(.playImmediate(.bang, target: "p2", actor: "p1")),
                                       .success(.luck),
                                       .success(.cancel)]
                }
            }

            context("flipped card is spades") {
                it("should skip turn") {
                    // Given
                    let state = createGame {
                        Player("p1") {
                            Hand {
                                .bang
                            }
                        }
                        Player("p2") {
                            InPlay {
                                .barrel
                            }
                        }
                        Deck {
                            "c1-A♠️"
                        }
                    }

                    // When
                    let action = GameAction.playImmediate(.bang, target: "p2", actor: "p1")
                    let result = self.awaitAction(action, choices: [.pass], state: state)

                    // Then
                    expect(result) == [.success(.playImmediate(.bang, target: "p2", actor: "p1")),
                                       .success(.luck),
                                       .success(.chooseOne(player: "p2", options: [
                                        .pass: .damage(1, player: "p2")
                                       ])),
                                       .success(.damage(1, player: "p2"))]
                }
            }
        }
    }
}

