//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Celio Junior on 01/07/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
