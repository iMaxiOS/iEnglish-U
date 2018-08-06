//
//  ViewController.swift
//  iEnglish U
//
//  Created by iMaxiOS on 8/1/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfParsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
        }
    
    var flipcount = 0 {
        didSet {
            flipsCountLabel.text = "Flips: \(flipcount)"
        }
    }
    
    @IBOutlet weak var flipsCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipcount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setAttributedTitle(phrase(for: card), for: .normal)
                
                // settings for button
                button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                button.titleLabel?.numberOfLines = 0
                button.titleLabel?.textAlignment = .center
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                let attrString = NSMutableAttributedString(string: "")
                button.setAttributedTitle(attrString, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var phraseChoices = ["You're welcome \n Пожалуйста", "Not at all \n Совсем нет", "Don't mention it \n Не за что", "That's all right \n Все в порядке", "Never mind \n Ничего", "It's my pleasure \n Не стоит"]
    var phrase = [Int: String]()
    
    func phrase(for card: Card) -> NSAttributedString {
        
        if phrase[card.identifier] == nil, phraseChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(phraseChoices.count)))
            phrase[card.identifier] = phraseChoices.remove(at: randomIndex)
        }
        
        let outputString = phrase[card.identifier] ?? "?"
        
        return  buttonCustomTwoLinesOfText(from: outputString as NSString)
        
    }
    
    // Make custom button with two lines
    func buttonCustomTwoLinesOfText(from phrase: NSString) -> NSAttributedString {
        
        let newlineRange: NSRange = phrase.range(of: "\n")
        
        //getting both substrings
        var substring1: NSString = ""
        var substring2: NSString = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = phrase.substring(to: newlineRange.location) as NSString
            substring2 = phrase.substring(from: newlineRange.location) as NSString
        }
        
        //assigning diffrent fonts to both substrings
        //first substring
        let font = UIFont(name: "Arial", size: 17.0)
        let attributes: [NSAttributedStringKey: Any] = [
            .font: font!,
            .foregroundColor: UIColor.black,
            ]
        let attrString = NSMutableAttributedString(string: substring1 as String, attributes: attributes)
        
        //second substring
        let font1 = UIFont(name: "Arial", size: 10.0)
        let attributes1: [NSAttributedStringKey: Any] = [
            .font: font1!,
            .foregroundColor: UIColor.black,
            ]
        let attrString1 = NSMutableAttributedString(string: substring2 as String, attributes: attributes1)
        
        //appending both attributed strings
        attrString.append(attrString1)
        
        return attrString
    }
}

