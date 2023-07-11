//
//  Inventory.swift
//  
//
//  Created by Hugues Telolahy on 11/07/2023.
//
import Game

public enum Inventory {
    public static func createGame(playersCount: Int) -> GameState {
        let abilities: [String] = [
            .endTurn,
            .drawOnSetTurn,
            .eliminateOnLooseLastHealth,
            .gameOverOnEliminated,
            .discardCardsOnEliminated,
            .nextTurnOnEliminated
        ]
        #warning("define a set of figures with attributes")
        let figureNames: [String] = [
            .willyTheKid,
            .roseDoolan,
            .paulRegret,
            .jourdonnais,
            .slabTheKiller,
            .luckyDuke,
            .calamityJanet,
            .bartCassidy,
            .elGringo,
            .suzyLafayette,
            .vultureSam,
            .sidKetchum,
            .blackJack,
            .kitCarlson,
            .jesseJones,
            .pedroRamirez
        ]

        let allFigures = figureNames
            .map { Figure(name: $0, bullets: 4, abilities: []) }

        let figures = Array(allFigures.shuffled().prefix(playersCount))
        let deck = Setup.createDeck(cardSets: CardSets.bang)
        
        let game = Setup.createGame(figures: figures,
                                    abilities: abilities,
                                    deck: deck)
            .cardRef(CardList.all)
        
        return game
    }
}
