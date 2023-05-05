//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 12/04/2023.
//
import Game

public enum CardList {
    public static let all: [String: Card] = createCards {

        // MARK: - Collectible

        Card(.beer) {
            onPlay(content: {
                CardEffect.heal(1, player: .actor)
            }, require: {
                PlayReq.isDamaged
                PlayReq.isPlayersAtLeast(3)
            })
        }

        Card(.saloon) {
            onPlay(content: {
                CardEffect.heal(1, player: .damaged)
            }, require: {
                PlayReq.isAnyDamaged
            })
        }

        Card(.stagecoach) {
            onPlay {
                CardEffect.replay(2) {
                    CardEffect.draw(player: .actor)
                }
            }
        }

        Card(.wellsFargo) {
            onPlay {
                CardEffect.replay(3) {
                    CardEffect.draw(player: .actor)
                }
            }
        }

        Card(.catBalou) {
            onPlay(target: .selectAnyWithCard) {
                CardEffect.discard(player: .target, card: .selectAny)
            }
        }

        Card(.panic) {
            onPlay(target: .selectAtRangeWithCard(1)) {
                CardEffect.steal(player: .actor, target: .target, card: .selectAny)
            }
        }
        
        Card(.generalStore) {
            onPlay {
                CardEffect.group {
                    CardEffect.replay(.numPlayers) {
                        CardEffect.reveal
                    }
                    CardEffect.chooseCard(player: .all, card: .selectChoosable)
                }
            }
        }

        Card(.bang) {
            onPlay(target: .selectReachable,
                   content: {
                CardEffect.forceDiscard(player: .target,
                                        card: .selectHandNamed(.missed),
                                        otherwise: .damage(1, player: .target))
            }, require: {
                PlayReq.isTimesPerTurn(1)
            })
        }

        Card(.missed)

        Card(.gatling) {
            onPlay {
                CardEffect.apply(target: .others) {
                    CardEffect.forceDiscard(player: .target,
                                            card: .selectHandNamed(.missed),
                                            otherwise: .damage(1, player: .target))
                }
            }
        }

        Card(.indians) {
            onPlay {
                CardEffect.apply(target: .others) {
                    CardEffect.forceDiscard(player: .target,
                                            card: .selectHandNamed(.bang),
                                            otherwise: .damage(1, player: .target))
                }
            }
        }

        Card(.duel) {
            onPlay(target: .selectAny) {
                CardEffect.challengeDiscard(player: .target,
                                            card: .selectHandNamed(.bang),
                                            otherwise: .damage(1, player: .target),
                                            challenger: .actor)
            }
        }

        // MARK: - Abilities

        Card(.endTurn) {
            onPlay {
                CardEffect.group {
                    CardEffect.replay(.excessHand) {
                        CardEffect.discard(player: .actor, card: .selectHand)
                    }
                    CardEffect.setTurn(.next)
                }
            }
        }
        
        Card(.drawOnSetTurn) {
            onPlay {
                CardEffect.replay(.startTurnCards) {
                    CardEffect.draw(player: .actor)
                }
            } require: {
                PlayReq.onSetTurn
            }
        }

        Card(.eliminateOnLooseLastHealth) {
            onPlay {
                CardEffect.eliminate(.actor)
            } require: {
                PlayReq.onLooseLastHealth
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
