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
                .require {
                    PlayReq.isPlayersAtLeast(3)
                }
                .triggered(.onPlay)
        }
        
        Card(.saloon) {
            CardEffect.heal(1, player: .target)
                .target(.damaged)
                .triggered(.onPlay)
        }
        
        Card(.stagecoach) {
            CardEffect.draw(player: .actor)
                .replay(2)
                .triggered(.onPlay)
        }
        
        Card(.wellsFargo) {
            CardEffect.draw(player: .actor)
                .replay(3)
                .triggered(.onPlay)
        }
        
        Card(.catBalou) {
            CardEffect.discard(player: .target, card: .selectAny, chooser: .actor)
                .target(.selectAnyWithCard)
                .triggered(.onPlay)
        }
        
        Card(.panic) {
            CardEffect.steal(player: .actor, target: .target, card: .selectAny)
                .target(.selectAtRangeWithCard(1))
                .triggered(.onPlay)
        }
        
        Card(.generalStore) {
            CardEffect.group {
                CardEffect.reveal
                    .replay(.numPlayers)
                CardEffect.chooseCard(player: .target, card: .selectArena)
                    .target(.all)
            }
            .triggered(.onPlay)
        }
        
        Card(.bang) {
            CardEffect.discard(player: .target, card: .selectHandNamed(.missed))
                .otherwise(.damage(1, player: .target))
                .target(.selectReachable)
                .require {
                    PlayReq.isTimesPerTurn(1)
                }
                .triggered(.onPlay)
        }
        
        Card(.missed)
        
        Card(.gatling) {
            CardEffect.discard(player: .target, card: .selectHandNamed(.missed))
                .otherwise(.damage(1, player: .target))
                .target(.others)
                .triggered(.onPlay)
        }
        
        Card(.indians) {
            CardEffect.discard(player: .target, card: .selectHandNamed(.bang))
                .otherwise(.damage(1, player: .target))
                .target(.others)
                .triggered(.onPlay)
        }

        Card(.duel) {
            CardEffect.discard(player: .target, card: .selectHandNamed(.bang))
                .challenge(target: .target, challenger: .actor, otherwise: .damage(1, player: .target))
                .target(.selectAny)
                .triggered(.onPlay)
        }
        
        // MARK: - Abilities
        
        Card(.endTurn) {
            CardEffect.group {
                CardEffect.discard(player: .actor, card: .selectHand)
                    .replay(.excessHand)
                CardEffect.setTurn(.next)
            }
            .triggered(.onPlay)
        }
        
        Card(.drawOnSetTurn) {
            CardEffect.draw(player: .actor)
                .replay(.playerAttr(.starTurnCards))
                .triggered(.onSetTurn)
        }
        
        Card(.eliminateOnLooseLastHealth) {
            CardEffect.eliminate(.actor)
                .triggered(.onLooseLastHealth)
        }

        Card(.nextTurnOnEliminated) {
            CardEffect.setTurn(.next)
                .require {
                    PlayReq.isCurrentTurn
                }
                .triggered(.onEliminated)
        }

        Card(.discardCardsOnEliminated)
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
