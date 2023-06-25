//
//  StagecoachSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

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
                    Player("p2")
                    Deck {
                        "c1"
                        "c2"
                    }
                }
                
                // When
                let action = GameAction.play(.stagecoach, actor: "p1")
                let result = self.awaitAction(action, state: state)
                
                // Then
                expect(result) == [.success(.playImmediate(.stagecoach, actor: "p1")),
                                   .success(.draw(player: "p1")),
                                   .success(.draw(player: "p1"))]
            }
        }
    }
}
