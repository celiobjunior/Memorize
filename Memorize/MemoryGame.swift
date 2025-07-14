//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Celio Junior on 05/07/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "m" : "nm")"
        }
    }
    
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // let faceUpCardIndices = cards.indices.filter  { index in cards[index].isFaceUp }
        // return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }}
    }
    
    mutating func choose(_ card: Card) {
        // Procura no array cards a carta com o mesmo id da carta escolhida
        // Se encontrar, armazena o índice em choosenIndex
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id})
        {
            // Só processa se a carta não estiver virada para cima (!isFaceUp)
            // E se não estiver combinada (!isMatched)
            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched
            {
                // Cenário A: Já existe uma carta virada
                // Se indexOfTheOneAndOnlyFaceUpCard tem valor, significa que já há uma carta virada
                if let potencialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
                {
                    // Compara o conteúdo das duas cartas:
                    
                    // Se combinam: marca ambas como isMatched = true
                    // Se não combinam: nada acontece (ambas ficam viradas)
                    if cards[choosenIndex].content == cards[potencialMatchIndex].content
                    {
                        cards[choosenIndex].isMatched = true
                        cards[potencialMatchIndex].isMatched = true
                    }
                }
                
                // Cenário B: Nenhuma carta está virada
                // Ou terceira carta a ser virada (caso duas já estejam visíveis)
                else
                {
                    // Define a carta atual como a única virada (indexOfTheOneAndOnlyFaceUpCard)
                    indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                }
                // Irá tirar as cartas de false para true
                // O loop acima reseta esse comportamento
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
