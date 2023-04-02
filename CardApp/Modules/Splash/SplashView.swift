//
//  SplashView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct SplashView: View {

    @EnvironmentObject var store: CardAppStore

    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 120.0, height: 120.0, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        store.dispatch(.showScreen(.home))
                    }
                }
            VStack(spacing: 8) {
                Spacer()
                Text("Stéphano Telolahy").font(.subheadline).foregroundColor(.primary)
                Text("stephano.telolahy@gmail.com").font(.subheadline).foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(CardAppStore.preview)
    }
}
