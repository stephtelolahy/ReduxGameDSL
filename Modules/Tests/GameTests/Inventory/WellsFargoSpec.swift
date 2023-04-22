//
//  WellsFargoSpec.swift
//  
//
//  Created by Hugues Telolahy on 10/04/2023.
//

import Quick
import Nimble
import Game

final class WellsFargoSpec: QuickSpec {
    override func spec() {
        describe("playing wellsFargo") {
            it("should draw 3 cards") {
                // Given
                let state = GameState {
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
                let sut = createGameStore(initial: state)

                // When
                let action = GameAction.play(actor: "p1", card: .wellsFargo)
                let result = self.awaitAction(action, store: sut)

                // Then
                let ctx = EffectContext(actor: "p1", card: .wellsFargo)
                expect(result) == [.success(.play(actor: "p1", card: .wellsFargo)),
                                   .success(.apply(.draw(player: .id("p1")), ctx: ctx)),
                                   .success(.apply(.draw(player: .id("p1")), ctx: ctx)),
                                   .success(.apply(.draw(player: .id("p1")), ctx: ctx))]
            }
        }
    }
}
