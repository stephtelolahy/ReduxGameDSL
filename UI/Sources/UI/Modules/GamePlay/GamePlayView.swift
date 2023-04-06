//
//  GamePlayView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct GamePlayView: View {
    @EnvironmentObject var store: AppStore

    private var state: GamePlayState? {
        nil
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
            Spacer()
            Text("Message: \(state?.message ?? "")")
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
            .environmentObject(AppStore.preview)
    }
}
#endif
