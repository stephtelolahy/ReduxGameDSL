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
        .init()
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
    static var previews: some View {
        GamePlayView()
            .environmentObject(previewStore)
    }
}
#endif
