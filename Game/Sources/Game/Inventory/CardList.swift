//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 12/04/2023.
//

public enum CardList {

    static let cardRef: [String: Card] = createCards {
        Card(.beer) {
            CardEffect.heal(1, player: .actor)
                .onPlay {
                    PlayReq.isActorDamaged
                    PlayReq.isPlayersAtLeast(3)
                }
        }
        Card(.saloon) {
            CardEffect.heal(1, player: .damaged)
                .onPlay {
                    PlayReq.isAnyDamaged
                }
        }
        Card(.stagecoach) {
            CardEffect.replay(2) {
                CardEffect.draw(player: .actor)
            }
            .onPlay()
        }
        Card(.wellsFargo) {
            CardEffect.replay(3) {
                CardEffect.draw(player: .actor)
            }
            .onPlay()
        }
        Card(.catBalou) {
            CardEffect.discard(player: .target, card: .selectAny)
                .onPlay(target: .selectAnyWithCard)
        }
        Card(.panic) {
            CardEffect.steal(player: .actor, target: .target, card: .selectAny)
                .onPlay(target: .selectAtRangeWithCard(1))
        }
        Card(.generalStore) {
            CardEffect.group {
                CardEffect.replay(.numPlayers) {
                    CardEffect.reveal
                }
                CardEffect.chooseCard(player: .all, card: .selectChoosable)
            }
            .onPlay()
        }
    }

    private static func createCards(@CardBuilder _ content: () -> [Card]) -> [String: Card] {
        content().toDictionary()
    }
}

private extension Array where Element == Card {
    func toDictionary() -> [String: Card] {
        reduce(into: [String: Card]()) {
            $0[$1.name] = $1
        }
    }
}
