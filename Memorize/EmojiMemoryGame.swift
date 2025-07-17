//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Celio Junior on 05/07/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🎃", "🕷️", "🕸️", "👻", "👿", "👹", "🙀", "🍭", "🪦"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var color: Color {
        return .orange
    }
    
    func shuffle() {
        model.shuffle()
        print(cards)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
