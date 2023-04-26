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
                let sut = createGameStore(initial: state)

                // When
                let action = GameAction.play(actor: "p1", card: .stagecoach)
                let result = self.awaitAction(action, store: sut)

                // Then
                let ctx = EffectContext(actor: "p1", card: .stagecoach)
                expect(result) == [.success(.play(actor: "p1", card: .stagecoach)),
                                   .success(.draw(player: .id("p1"), ctx: ctx)),
                                   .success(.draw(player: .id("p1"), ctx: ctx))]
            }
        }
    }
}
