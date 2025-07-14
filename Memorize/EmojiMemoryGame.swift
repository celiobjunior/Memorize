//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Celio Junior on 05/07/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let themes = [
        "Theme1": ["🎃", "🕷️", "🕸️", "👻", "👿", "👹", "🙀", "🍭", "🪦"],
        "Theme2": ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "🐿️"],
        "Theme3": ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍑"]
    ]
    
    private static func createMemoryGame(emojis: [String]) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 9) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }
        
    @Published private var model = createMemoryGame(emojis: [])
    
    init(theme: String = "Theme1") {
        let themedEmojis = EmojiMemoryGame.themes.randomElement()!.value
        model = EmojiMemoryGame.createMemoryGame(emojis: themedEmojis)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let themedEmojis = EmojiMemoryGame.themes.randomElement()!.value
        model = EmojiMemoryGame.createMemoryGame(emojis: themedEmojis)
    }
}
