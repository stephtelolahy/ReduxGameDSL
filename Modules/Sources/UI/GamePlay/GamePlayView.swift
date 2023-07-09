//
//  GamePlayView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI
import Redux

struct GamePlayView: View {
    @EnvironmentObject private var store: Store<AppState, Action>

    private var state: GamePlay.State {
        guard let lastScreen = store.state.screens.last, case let .game(state) = lastScreen else {
            fatalError("missing GamePlay.State")
        }
        return state
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    store.dispatch(.dismissScreen(.game))
                }
            } label: {
                HStack {
                    Image(systemName: "hand.point.left.fill")
                    Text("Give Up")
                }
                .foregroundColor(.accentColor)
            }
            .padding()
            List {
                Section {
                    ForEach(state.players) { player in
                        PlayerView(player: player)
                    }
                }
            }
            Text("Message: \(state.message)")
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .padding()
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    private static var previewStore: Store<AppState, Action> = {
        let state = GamePlay.State(
            game: nil,
            controlled: nil,
            players: [
                PlayerViewModel(id: "turtlerock1", name: "turtlerock"),
                PlayerViewModel(id: "turtlerock2", name: "turtlerock")
            ]
        )

        return Store<AppState, Action>(
            initial: AppState(screens: [.game(state)]),
            reducer: { state, _ in state },
            middlewares: []
        )
    }()

    static var previews: some View {
        GamePlayView()
            .environmentObject(previewStore)
    }
}
#endif
