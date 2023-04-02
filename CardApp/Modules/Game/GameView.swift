//
//  GameView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var store: CardAppStore

    var body: some View {
      VStack(alignment: .leading) {
        Button {
          withAnimation {
              store.dispatch(.showScreen(.home))
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
        Text("Moves: 0")
          .font(.subheadline)
          .foregroundColor(.purple)
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(CardAppStore.preview)
    }
}
