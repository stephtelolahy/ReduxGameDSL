//
//  ContentView.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: CardAppStore
    
    var body: some View {
        // TODO: display content according to store's current screen
        SplashView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(store)
    }
}
