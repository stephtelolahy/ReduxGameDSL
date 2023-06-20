//
//  CardList.swift
//  
//
//  Created by Hugues Telolahy on 12/04/2023.
//

public enum CardList {

    // MARK: - Collectibles

    static let beer = Card(.beer) {
        CardEffect.heal(1)
            .target(.actor)
            .triggered(.onPlay)
            .require {
                PlayReq.isPlayersAtLeast(3)
            }
    }

    static let saloon = Card(.saloon) {
        CardEffect.heal(1)
            .target(.damaged)
            .triggered(.onPlay)
    }

    static let stagecoach = Card(.stagecoach) {
        CardEffect.draw
            .target(.actor)
            .repeat(2)
            .triggered(.onPlay)
    }

    static let wellsFargo = Card(.wellsFargo) {
        CardEffect.draw
            .target(.actor)
            .repeat(3)
            .triggered(.onPlay)
    }

    static let catBalou = Card(.catBalou) {
        CardEffect.discard(.selectAny, chooser: .actor)
            .target(.selectAnyWithCard)
            .triggered(.onPlay)
    }

    static let panic = Card(.panic) {
        CardEffect.steal(.selectAny, chooser: .actor)
            .target(.selectAtRangeWithCard(1))
            .triggered(.onPlay)
    }

    static let generalStore = Card(.generalStore) {
        CardEffect.group {
            CardEffect.drawToArena
                .repeat(.numPlayers)
            CardEffect.chooseCard
                .target(.all)
        }
        .triggered(.onPlay)
    }

    static let bang = Card(.bang) {
        CardEffect.discard(.selectHandNamed(.missed))
            .otherwise(.damage(1))
            .target(.selectReachable)
            .triggered(.onPlay)
            .require {
                PlayReq.isTimesPerTurn(1)
            }
    }

    static let missed = Card(.missed)

    static let gatling = Card(.gatling) {
        CardEffect.discard(.selectHandNamed(.missed))
            .otherwise(.damage(1))
            .target(.others)
            .triggered(.onPlay)
    }

    static let indians = Card(.indians) {
        CardEffect.discard(.selectHandNamed(.bang))
            .otherwise(.damage(1))
            .target(.others)
            .triggered(.onPlay)
    }

    static let duel = Card(.duel) {
        CardEffect.discard(.selectHandNamed(.bang))
            .challenge(.actor, otherwise: .damage(1))
            .target(.selectAny)
            .triggered(.onPlay)
    }

    static let barrel = Card(.barrel, type: .equipment) {
        CardEffect.nothing
            .triggered(.onPlay)
    }

    static let dynamite = Card(.dynamite, type: .equipment) {
        CardEffect.nothing
            .triggered(.onPlay)
    }

    static let jail = Card(.jail, type: .handicap) {
        CardEffect.nothing
            .target(.selectAny)
            .triggered(.onPlay)
    }

    // MARK: - Abilities

    static let endTurn = Card(.endTurn) {
        CardEffect.group {
            CardEffect.discard(.selectHand)
                .target(.actor)
                .repeat(.excessHand)
            CardEffect.setTurn
                .target(.next)
        }
        .triggered(.onPlay)
    }

    static let drawOnSetTurn = Card(.drawOnSetTurn) {
        CardEffect.draw
            .target(.actor)
            .repeat(.playerAttr(.starTurnCards))
            .triggered(.onSetTurn)
    }

    static let eliminateOnLooseLastHealth = Card(.eliminateOnLooseLastHealth) {
        CardEffect.eliminate
            .target(.actor)
            .triggered(.onLooseLastHealth)
    }

    static let nextTurnOnEliminated = Card(.nextTurnOnEliminated) {
        CardEffect.setTurn
            .target(.next)
            .triggered(.onEliminated)
            .require {
                PlayReq.isCurrentTurn
            }
    }

    static let discardCardsOnEliminated = Card(.discardCardsOnEliminated) {
        CardEffect.discard(.all)
            .target(.actor)
            .triggered(.onEliminated)
    }

    public static let all: [String: Card] = createCards {
        beer
        saloon
        stagecoach
        wellsFargo
        catBalou
        panic
        generalStore
        bang
        missed
        gatling
        indians
        duel
        barrel
        dynamite
        jail
        endTurn
        drawOnSetTurn
        eliminateOnLooseLastHealth
        nextTurnOnEliminated
        discardCardsOnEliminated
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
