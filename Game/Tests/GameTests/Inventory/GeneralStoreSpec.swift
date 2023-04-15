//
//  GeneralStoreSpec.swift
//  
//
//  Created by Hugues Telolahy on 15/04/2023.
//

import Quick
import Nimble
import Game

final class GeneralStoreSpec: QuickSpec {
    override func spec() {
        describe("playing generalStore") {
            it("should allow each player to choose a card") {
                // Given
                let state = GameState {
                    Player("p1") {
                        Hand {
                            "generalStore-9♣️"
                        }
                    }
                    Player("p2")
                    Player("p3")
                    Deck {
                        "c1"
                        "c2"
                        "c3"
                    }
                }
                let sut = createGameStore(initial: state)

                // When
                var action = GameAction.play(actor: "p1", card: "generalStore-9♣️")
                var result = self.awaitAction(action, store: sut)

                // Then
                let ctx = EffectContext(actor: "p1", card: "generalStore-9♣️")
                expect(result) == [.success(.play(actor: "p1", card: "generalStore-9♣️")),
                                   .success(.apply(.reveal, ctx: ctx)),
                                   .success(.apply(.reveal, ctx: ctx)),
                                   .success(.apply(.reveal, ctx: ctx))]
                expect(sut.state.chooseOne) == [
                    "c1": .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx),
                    "c2": .apply(.chooseCard(player: .id("p1"), card: .id("c2")), ctx: ctx),
                    "c3": .apply(.chooseCard(player: .id("p1"), card: .id("c3")), ctx: ctx)
                ]

                // When p1 choose
                action = .apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx)
                result = self.awaitAction(action, store: sut)

                // Then
                expect(result) == [
                    .success(.apply(.chooseCard(player: .id("p1"), card: .id("c1")), ctx: ctx))
                ]
                expect(sut.state.chooseOne) == [
                    "c2": .apply(.chooseCard(player: .id("p2"), card: .id("c2")), ctx: ctx),
                    "c3": .apply(.chooseCard(player: .id("p2"), card: .id("c3")), ctx: ctx)
                ]

                // When p2 choose
                action = .apply(.chooseCard(player: .id("p2"), card: .id("c2")), ctx: ctx)
                result = self.awaitAction(action, store: sut)

                // Then
                expect(result) == [
                    .success(.apply(.chooseCard(player: .id("p2"), card: .id("c2")), ctx: ctx)),
                    .success(.apply(.chooseCard(player: .id("p3"), card: .id("c3")), ctx: ctx))
                ]
                expect(sut.state.chooseOne) == nil
            }
        }
    }
}
