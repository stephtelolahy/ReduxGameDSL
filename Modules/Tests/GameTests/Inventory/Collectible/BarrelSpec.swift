//
//  BarrelTests.swift
//  
//
//  Created by Hugues Telolahy on 18/06/2023.
//

import Quick
import Nimble
import Game

final class BarrelSpec: QuickSpec {
    override func spec() {
        describe("playing barrel") {
            it("should equip") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .barrel
                        }
                    }
                }

                // When
                let action = GameAction.play(actor: "p1", card: .barrel)
                let result = self.awaitAction(action, state: state)

                // Then
                expect(result) == [.success(.playEquipment(actor: "p1", card: .barrel))]
            }
        }
        
        describe("triggering barrel") {
            it("should counter bang effect") {
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
                let action = GameAction.play(actor: "p1", card: .bang)
                let result = self.awaitAction(action, choices: ["p2"], state: state)

                // Then
                expect(result) == [.success(.playImmediate(actor: "p1", card: .bang, target: "p2")),
                                   .success(.drawToDiscard),
                                   .success(.cancel)]
            }
        }
    }
}
