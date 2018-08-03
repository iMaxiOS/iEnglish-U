//
//  Concentration.swift
//  iEnglish U
//
//  Created by iMaxiOS on 8/3/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        <#function body#>
    }
    
    init(numberOfParsOfCards: Int) {
        for _ in 1...numberOfParsOfCards {
            let card = Card()
            cards += [card,card]
        }
        //TODO: Shuffle the cards
    }
}
