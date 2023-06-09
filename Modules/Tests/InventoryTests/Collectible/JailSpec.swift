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
                let state = createGameWithCardRef {
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
                    .chooseOne(player: "p1", options: [
                        "p2": .playHandicap(.jail, target: "p2", actor: "p1")
                    ]),
                    .playHandicap(.jail, target: "p2", actor: "p1")
                ]
            }

            // TODO: cannot play jail against sheriff
        }
        
        describe("triggering jail") {
            context("flipped card is hearts") {
                it("should scape from jail") {
                    // Given
                    let state = createGameWithCardRef {
                        Player("p1") {
                            InPlay {
                                .jail
                            }
                        }
                        Player("p2")
                        Deck {
                            "c1-2♥️"
                            "c2"
                            "c3"
                        }
                    }
                        .ability(.drawOnSetTurn)

                    // When
                    let action = GameAction.setTurn("p1")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.setTurn("p1"),
                                       .luck,
                                       .discard(.jail, player: "p1"),
                                       .draw(player: "p1"),
                                       .draw(player: "p1")]
                }
            }

            context("flipped card is spades") {
                it("should skip turn") {
                    // Given
                    let state = createGameWithCardRef {
                        Player("p1") {
                            InPlay {
                                .jail
                            }
                        }
                        Player("p2")
                        Deck {
                            "c1-A♠️"
                            "c2"
                            "c3"
                            "c4"
                            "c5"
                        }
                    }
                        .ability(.drawOnSetTurn)

                    // When
                    let action = GameAction.setTurn("p1")
                    let result = self.awaitAction(action, state: state)

                    // Then
                    expect(result) == [.setTurn("p1"),
                                       .luck,
                                       .cancel(.effectOfCardNamed(.drawOnSetTurn)),
                                       .discard(.jail, player: "p1"),
                                       .setTurn("p2"),
                                       .draw(player: "p2"),
                                       .draw(player: "p2")]
                }
            }
        }
    }
}
