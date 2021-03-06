//
//  Concentration.swift
//  iEnglish U
//
//  Created by iMaxiOS on 8/3/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index): chosen index not in the card")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfParsOfCards: Int) {
        assert(numberOfParsOfCards > 0, "Concentration.init(\(numberOfParsOfCards): you must have at least one pair of cards")
        for _ in 1...numberOfParsOfCards {
            let card = Card()
            cards += [card,card]
        }
        // Shuffle the cards
        cards.shuffle()
    }
}


