//
//  WellsFargoSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class WellsFargoSpec: QuickSpec {
    override func spec() {
        describe("playing wellsFargo") {
            it("should draw 3 cards") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .wellsFargo
                        }
                    }
                    Player("p2")
                    Deck {
                        "c1"
                        "c2"
                        "c3"
                    }
                }
                
                // When
                let action = GameAction.move(actor: "p1", card: .wellsFargo)
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [.success(.playImmediate(actor: "p1", card: .wellsFargo)),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1"))]
            }
        }
    }
}
