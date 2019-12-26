//
//  main.swift
//  day-22
//
//  Created by Vladimir Svidersky on 12/26/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

class Deck {
    var cards: [Int]
    
    init(size: Int) {
        self.cards = [Int]()
        for i in 0..<size {
            self.cards.append(i)
        }
    }
    
    func dealNewStack() {
        var cardsNew = [Int]()
        
        for i in cards {
            cardsNew.insert(i, at: 0)
        }
        cards = cardsNew
    }
    
    func cut(n: Int) {
        var cardsNew = [Int]()
        if n > 0 {
            cardsNew.append(contentsOf: cards[n...])
            cardsNew.append(contentsOf: cards[0...n-1])
        }
        else {
            let i = cards.count+n
            cardsNew.append(contentsOf: cards[i...])
            cardsNew.append(contentsOf: cards[0...i-1])
        }
        cards = cardsNew
    }
    
    func dealWithIncrement(n: Int) {
        var cardsNew = [Int](repeating: -1, count: cards.count)
        var index = 0
        for c in cards {
            cardsNew[index] = c
            index += n
            if index >= cards.count {
                index -= cards.count
            }
        }
        
        cards = cardsNew
    }
}

var deck = Deck(size: 10007)
for step in input {
    switch step.0 {
    case .new:
        deck.dealNewStack()
    case .deal:
        deck.dealWithIncrement(n: step.1)
    case .cut:
        deck.cut(n: step.1)
    }
}

print(deck.cards.firstIndex(of: 2019))

