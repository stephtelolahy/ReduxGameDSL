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
                    Deck {
                        "c1"
                        "c2"
                        "c3"
                    }
                }
                
                // When
                let result = self.awaitAction(.play(actor: "p1", card: .wellsFargo), state: state)
                
                // Then
                expect(result) == [.success(.play(actor: "p1", card: .wellsFargo)),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1"))]
            }
        }
    }
}
