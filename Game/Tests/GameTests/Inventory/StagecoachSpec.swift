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
                let state = GameState {
                    Player("p1") {
                        Hand {
                            "stagecoach-9♠️"
                        }
                    }
                    Deck {
                        "c1"
                        "c2"
                    }
                }
                let sut = createGameStore(initial: state)

                // When
                let action = GameAction.play(actor: "p1", card: "stagecoach-9♠️")
                let result = self.awaitAction(action, store: sut)

                // Then
                let ctx = PlayContext(actor: "p1", card: "stagecoach-9♠️")
                expect(result) == [.success(.play(actor: "p1", card: "stagecoach-9♠️")),
                                   .success(.apply(.draw(player: .id("p1")), ctx: ctx)),
                                   .success(.apply(.draw(player: .id("p1")), ctx: ctx))]
            }
        }
    }
}
