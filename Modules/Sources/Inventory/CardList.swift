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
            CardEffect.heal(1, player: .actor)
                .triggered(on: .play)
                .require {
                    PlayReq.isDamaged
                    PlayReq.isPlayersAtLeast(3)
                }
        }

        Card(.saloon) {
            CardEffect.heal(1, player: .damaged)
                .triggered(on: .play)
                .require {
                    PlayReq.isAnyDamaged
                }
        }

        Card(.stagecoach) {
            CardEffect.replay(2) {
                CardEffect.draw(player: .actor)
            }
            .triggered(on: .play)
        }

        Card(.wellsFargo) {
            CardEffect.replay(3) {
                CardEffect.draw(player: .actor)
            }
            .triggered(on: .play)
        }

        Card(.catBalou) {
            CardEffect.discard(player: .target, card: .selectAny)
                .triggered(on: .play, target: .selectAnyWithCard)
        }

        Card(.panic) {
            CardEffect.steal(player: .actor, target: .target, card: .selectAny)
                .triggered(on: .play, target: .selectAtRangeWithCard(1))
        }

        Card(.generalStore) {
            CardEffect.group {
                CardEffect.replay(.numPlayers) {
                    CardEffect.reveal
                }
                CardEffect.chooseCard(player: .all, card: .selectArena)
            }
            .triggered(on: .play)
        }

        Card(.bang) {
            CardEffect.forceDiscard(player: .target,
                                    card: .selectHandNamed(.missed),
                                    otherwise: .damage(1, player: .target))
            .triggered(on: .play, target: .selectReachable)
            .require {
                PlayReq.isTimesPerTurn(1)
            }
        }

        Card(.missed)

        Card(.gatling) {
            CardEffect.apply(target: .others) {
                CardEffect.forceDiscard(player: .target,
                                        card: .selectHandNamed(.missed),
                                        otherwise: .damage(1, player: .target))
            }
            .triggered(on: .play)
        }

        Card(.indians) {
            CardEffect.apply(target: .others) {
                CardEffect.forceDiscard(player: .target,
                                        card: .selectHandNamed(.bang),
                                        otherwise: .damage(1, player: .target))
            }
            .triggered(on: .play)
        }

        Card(.duel) {
            CardEffect.challengeDiscard(player: .target,
                                        card: .selectHandNamed(.bang),
                                        otherwise: .damage(1, player: .target),
                                        challenger: .actor)
            .triggered(on: .play, target: .selectAny)
        }

        // MARK: - Abilities

        Card(.endTurn) {
            CardEffect.group {
                CardEffect.replay(.excessHand) {
                    CardEffect.discard(player: .actor, card: .selectHand)
                }
                CardEffect.setTurn(.next)
            }
            .triggered(on: .spell)
        }
        
        Card(.drawOnSetTurn) {
            CardEffect.replay(.playerAttr(.starTurnCards)) {
                CardEffect.draw(player: .actor)
            }
            .triggered(on: .event)
            .require {
                PlayReq.onSetTurn
            }
        }

        Card(.eliminateOnLooseLastHealth) {
            CardEffect.eliminate(.actor)
                .triggered(on: .event)
                .require {
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
