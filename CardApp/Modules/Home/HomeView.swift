//
//  HomeView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var store: CardAppStore

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Spacer()

            Image(systemName: "gamecontroller")
                .font(.system(size: 120))
            Button("New Game") {
                withAnimation {
                    store.dispatch(.showScreen(.game))
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(40)

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CardAppStore.preview)
    }
}
