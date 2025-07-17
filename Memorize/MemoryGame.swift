//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Celio Junior on 05/07/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "m" : "nm")"
        }
    }
    
    private(set) var cards: [Card]
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id})
        {
            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched
            {
                if let potencialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
                {
                    if cards[choosenIndex].content == cards[potencialMatchIndex].content
                    {
                        cards[choosenIndex].isMatched = true
                        cards[potencialMatchIndex].isMatched = true
                        
                        score += 2
                    }
                    else
                    {
                        if cards[choosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potencialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                }
                else
                {
                    indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                }
                cards[choosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
