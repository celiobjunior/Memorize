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
    
    private static func createMemoryGame(numCards: Int) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: numCards) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }
        
    @Published private var model = createMemoryGame(numCards: 9)
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(numCards: 9)
    }
}
