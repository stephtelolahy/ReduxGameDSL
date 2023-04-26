//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 12/04/2023.
//
import Game

public enum CardList {

    public static let all: [String: Card] = createCards {
        Card(.beer) {
            onPlay(content: {
                GameAction.heal(1, player: .actor)
            }, require: {
                PlayReq.isDamaged
                PlayReq.isPlayersAtLeast(3)
            })
        }

        Card(.saloon) {
            onPlay(content: {
                GameAction.heal(1, player: .damaged)
            }, require: {
                PlayReq.isAnyDamaged
            })
        }

        Card(.stagecoach) {
            onPlay {
                GameAction.replay(2) {
                    GameAction.draw(player: .actor)
                }
            }
        }

        Card(.wellsFargo) {
            onPlay {
                GameAction.replay(3) {
                    GameAction.draw(player: .actor)
                }
            }
        }

        Card(.catBalou) {
            onPlay(target: .selectAnyWithCard) {
                GameAction.discard(player: .target, card: .selectAny)
            }
        }

        Card(.panic) {
            onPlay(target: .selectAtRangeWithCard(1)) {
                GameAction.steal(player: .actor, target: .target, card: .selectAny)
            }
        }
        
        Card(.generalStore) {
            onPlay {
                GameAction.group {
                    GameAction.replay(.numPlayers) {
                        GameAction.reveal
                    }
                    GameAction.chooseCard(player: .all, card: .selectChoosable)
                }
            }
        }

        Card(.bang) {
            onPlay(target: .selectReachable,
                   content: {
                GameAction.forceDiscard(player: .target,
                                        card: .selectHandNamed(.missed),
                                        otherwise: .damage(1, player: .target))
            }, require: {
                PlayReq.isTimesPerTurn(1)
            })
        }

        Card(.missed)

        Card(.gatling) {
            onPlay {
                GameAction.apply(target: .others) {
                    GameAction.forceDiscard(player: .target,
                                            card: .selectHandNamed(.missed),
                                            otherwise: .damage(1, player: .target))
                }
            }
        }

        Card(.indians) {
            onPlay {
                GameAction.apply(target: .others) {
                    GameAction.forceDiscard(player: .target,
                                            card: .selectHandNamed(.bang),
                                            otherwise: .damage(1, player: .target))
                }
            }
        }

        Card(.duel) {
            onPlay(target: .selectAny) {
                GameAction.challengeDiscard(player: .target,
                                            card: .selectHandNamed(.bang),
                                            otherwise: .damage(1, player: .target),
                                            challenger: .actor)
            }
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
