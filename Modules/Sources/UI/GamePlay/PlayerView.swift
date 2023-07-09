//
//  PlayerView.swift
//  
//
//  Created by Hugues Telolahy on 09/07/2023.
//

import SwiftUI

struct PlayerView: View {
    let player: PlayerViewModel

    var body: some View {
        HStack {
            CircleImage(image: player.image)
            Text(player.name)
            Spacer()
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .padding()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerViewModel(id: "turtlerock", name: "turtlerock")
        Group {
            PlayerView(player: player)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

extension PlayerViewModel {
    var image: Image {
        Image(name)
    }
}
