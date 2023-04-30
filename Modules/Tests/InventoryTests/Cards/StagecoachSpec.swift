//
//  StagecoachSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game
import Inventory

final class StagecoachSpec: QuickSpec {
    override func spec() {
        describe("playing stagecoach") {
            it("should draw 2 cards") {
                // Given
                let state = createGame {
                    Player("p1") {
                        Hand {
                            .stagecoach
                        }
                    }
                    Deck {
                        "c1"
                        "c2"
                    }
                }
                
                // When
                let result = self.awaitAction(.play(actor: "p1", card: .stagecoach), state: state)
                
                // Then
                expect(result) == [.success(.play(actor: "p1", card: .stagecoach)),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1"))]
            }
        }
    }
}
