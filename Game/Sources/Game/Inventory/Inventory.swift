//
//  Inventory.swift
//  
//
//  Created by Hugues Telolahy on 04/04/2023.
//

public enum Inventory {

    /// Describing all cards
    public static let cardRef: [String: Card] = createCards {
        Card(.beer) {
            CardEffect.heal(1, player: .actor)
                .onPlay {
                    PlayReq.isPlayersAtLeast(3)
                }
        }
    }

    /// Describing card sets
    public static let cardSets: [String: [String]] = [
        .barrel: ["Q♠️", "K♠️"],
        .dynamite: ["2♥️"],
        .jail: ["J♠️", "10♠️", "4♥️"],
        .mustang: ["8♥️", "9♥️"],
        .remington: ["K♣️"],
        .revCarabine: ["A♣️"],
        .schofield: ["K♠️", "J♣️", "Q♣️"],
        .scope: ["A♠️"],
        .volcanic: ["10♠️", "10♣️"],
        .winchester: ["8♠️"],
        // swiftlint:disable:next line_length
        .bang: ["A♠️", "2♦️", "3♦️", "4♦️", "5♦️", "6♦️", "7♦️", "8♦️", "9♦️", "10♦️", "J♦️", "Q♦️", "K♦️", "A♦️", "2♣️", "3♣️", "4♣️", "5♣️", "6♣️", "7♣️", "8♣️", "9♣️", "Q♥️", "K♥️", "A♥️"],
        .missed: ["10♣️", "J♣️", "Q♣️", "K♣️", "A♣️", "2♠️", "3♠️", "4♠️", "5♠️", "6♠️", "7♠️", "8♠️"],
        .beer: ["6♥️", "7♥️", "8♥️", "9♥️", "10♥️", "J♥️"],
        .catBalou: ["K♥️", "9♦️", "10♦️", "J♦️"],
        .duel: ["Q♦️", "J♠️", "8♣️"],
        .gatling: ["10♥️"],
        .generalStore: ["9♣️", "Q♠️"],
        .indians: ["K♦️", "A♦️"],
        .panic: ["J♥️", "Q♥️", "A♥️", "8♦️"],
        .saloon: ["5♥️"],
        .stagecoach: ["9♠️", "9♠️"],
        .wellsFargo: ["3♥️"]
    ]
}

public extension String {

    // MARK: - Collectible

    static let bang = "bang"
    static let missed = "missed"
    static let beer = "beer"
    static let saloon = "saloon"
    static let stagecoach = "stagecoach"
    static let wellsFargo = "wellsFargo"
    static let generalStore = "generalStore"
    static let catBalou = "catBalou"
    static let panic = "panic"
    static let gatling = "gatling"
    static let indians = "indians"
    static let duel = "duel"
    static let barrel = "barrel"
    static let dynamite = "dynamite"
    static let jail = "jail"
    static let mustang = "mustang"
    static let remington = "remington"
    static let revCarabine = "revCarabine"
    static let schofield = "schofield"
    static let scope = "scope"
    static let volcanic = "volcanic"
    static let winchester = "winchester"

    // MARK: - Figures

    static let willyTheKid = "willyTheKid"
    static let roseDoolan = "roseDoolan"
    static let paulRegret = "paulRegret"
    static let jourdonnais = "jourdonnais"
    static let slabTheKiller = "slabTheKiller"
    static let luckyDuke = "luckyDuke"
    static let calamityJanet = "calamityJanet"
    static let bartCassidy = "bartCassidy"
    static let elGringo = "elGringo"
    static let suzyLafayette = "suzyLafayette"
    static let vultureSam = "vultureSam"
    static let sidKetchum = "sidKetchum"
    static let blackJack = "blackJack"
    static let kitCarlson = "kitCarlson"
    static let jesseJones = "jesseJones"
    static let pedroRamirez = "pedroRamirez"
}

private func createCards(@CardBuilder _ content: () -> [Card]) -> [String: Card] {
    content().toDictionary()
}

private extension Array where Element == Card {
    func toDictionary() -> [String: Card] {
        reduce(into: [String: Card]()) {
            $0[$1.name] = $1
        }
    }
}
