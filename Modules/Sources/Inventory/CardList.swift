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
            // TODO: emit error if resolving first action throws error
            CardEffect.heal(1, player: .actor)
                .triggered(on: .play)
                .require {
                    PlayReq.isDamaged
                    PlayReq.isPlayersAtLeast(3)
                }
        }

        Card(.saloon) {
            // TODO: emit error if resolving first action is empty
            CardEffect.heal(1, player: .target)
                .apply(to: .damaged)
                .triggered(on: .play)
                .require {
                    PlayReq.isAnyDamaged
                }
        }

        Card(.stagecoach) {
            CardEffect.draw(player: .actor)
                .replay(2)
                .triggered(on: .play)
        }

        Card(.wellsFargo) {
            CardEffect.draw(player: .actor)
                .replay(3)
                .triggered(on: .play)
        }

        Card(.catBalou) {
            CardEffect.discard(player: .target, card: .selectAny)
                .triggered(on: .play)
                .target(.selectAnyWithCard)
        }

        Card(.panic) {
            CardEffect.steal(player: .actor, target: .target, card: .selectAny)
                .triggered(on: .play)
                .target(.selectAtRangeWithCard(1))
        }

        Card(.generalStore) {
            CardEffect.group {
                CardEffect.reveal
                    .replay(.numPlayers)
                CardEffect.chooseCard(player: .target, card: .selectArena)
                    .apply(to: .all)
            }
            .triggered(on: .play)
        }

        Card(.bang) {
            CardEffect.forceDiscard(player: .target,
                                    card: .selectHandNamed(.missed),
                                    otherwise: .damage(1, player: .target))
            .triggered(on: .play)
            .target(.selectReachable)
            .require {
                PlayReq.isTimesPerTurn(1)
            }
        }

        Card(.missed)

        Card(.gatling) {
            CardEffect.forceDiscard(player: .target,
                                    card: .selectHandNamed(.missed),
                                    otherwise: .damage(1, player: .target))
            .apply(to: .others)
            .triggered(on: .play)
        }

        Card(.indians) {
            // TODO: modifier: otherwise
            CardEffect.forceDiscard(player: .target,
                                    card: .selectHandNamed(.bang),
                                    otherwise: .damage(1, player: .target))
            .apply(to: .others)
            .triggered(on: .play)
        }

        Card(.duel) {
            // TODO: modifier .targetChallenge(target, otherwise)
            CardEffect.challengeDiscard(player: .target,
                                        card: .selectHandNamed(.bang),
                                        otherwise: .damage(1, player: .target),
                                        challenger: .actor)
            .triggered(on: .play)
            .target(.selectAny)
        }

        // MARK: - Abilities

        Card(.endTurn) {
            CardEffect.group {
                CardEffect.discard(player: .actor, card: .selectHand)
                    .replay(.excessHand)
                CardEffect.setTurn(.next)
            }
            .triggered(on: .spell)
        }
        
        Card(.drawOnSetTurn) {
            CardEffect.draw(player: .actor)
                .replay(.playerAttr(.starTurnCards))
                .triggered(on: .immediately(.onSetTurn))
        }

        Card(.eliminateOnLooseLastHealth) {
            CardEffect.eliminate(.actor)
                .triggered(on: .immediately(.onLooseLastHealth))
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
