//
//  Setup.swift
//  
//
//  Created by Hugues Telolahy on 19/05/2023.
//

public enum Setup {
    public static func createGame(
        figures: [Figure],
        abilities: [String],
        deck: [String]
    ) -> GameState {
        let figures = figures.shuffled()
        var deck = deck.shuffled()
        let players: [Player] = figures.map { figure in
            let identifier = figure.name
            let health = figure.bullets
            let hand: [String] = Array(1...health).map { _ in deck.removeFirst() }
            var player = Player(identifier)
            player.hand = CardLocation(cards: hand, visibility: identifier)
            player.attributes[.maxHealth] = health
            player.attributes[.health] = health
            return player
        }

        var state = GameState()
        for player in players {
            state.players[player.id] = player
            state.setupOrder.append(player.id)
            state.playOrder.append(player.id)
        }
        state.abilities = Set(abilities)
        state.deck = CardStack(cards: deck)
        return state
    }
}

public struct Figure {
    let name: String
    let bullets: Int

    public init(name: String, bullets: Int) {
        self.name = name
        self.bullets = bullets
    }
}
