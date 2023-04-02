//
//  AppScreen.swift
//  CardApp
//
//  Created by Hugues Telolahy on 02/04/2023.
//
import Foundation

enum AppScreen: Equatable {
    case splash
    case home
    case game(id: String)
}

enum AppScreenState: Codable {
    case splash
    case home
    case game(GameState)
}
