//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 12/04/2023.
//

public enum CardList {

    static let cardRef: [String: Card] = createCards {
        Card(.beer) {
            GameAction.heal(1, player: .actor)
                .onPlay {
                    PlayReq.isDamaged
                    PlayReq.isPlayersAtLeast(3)
                }
        }
        Card(.saloon) {
            GameAction.heal(1, player: .damaged)
                .onPlay {
                    PlayReq.isAnyDamaged
                }
        }
        Card(.stagecoach) {
            GameAction.replay(2) {
                GameAction.draw(player: .actor)
            }
            .onPlay()
        }
        Card(.wellsFargo) {
            GameAction.replay(3) {
                GameAction.draw(player: .actor)
            }
            .onPlay()
        }
        Card(.catBalou) {
            GameAction.discard(player: .target, card: .selectAny)
                .onPlay(target: .selectAnyWithCard)
        }
        Card(.panic) {
            GameAction.steal(player: .actor, target: .target, card: .selectAny)
                .onPlay(target: .selectAtRangeWithCard(1))
        }
        Card(.generalStore) {
            GameAction.group {
                GameAction.replay(.numPlayers) {
                    GameAction.reveal
                }
                GameAction.chooseCard(player: .all, card: .selectChoosable)
            }
            .onPlay()
        }
        Card(.bang) {
            GameAction.forceDiscard(player: .target,
                                    card: .selectHandNamed(.missed),
                                    otherwise: .damage(1, player: .target))
            .onPlay(target: .selectReachable) {
                PlayReq.isTimesPerTurn(1)
            }
        }
        Card(.missed)
        Card(.gatling) {
            GameAction.apply(target: .others) {
                GameAction.forceDiscard(player: .target,
                                        card: .selectHandNamed(.missed),
                                        otherwise: .damage(1, player: .target))
            }
            .onPlay()
        }
        Card(.indians) {
            GameAction.apply(target: .others) {
                GameAction.forceDiscard(player: .target,
                                        card: .selectHandNamed(.bang),
                                        otherwise: .damage(1, player: .target))
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
