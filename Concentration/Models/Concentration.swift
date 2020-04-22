//
//  Concentration.swift
//  Concentration
//
//  Created by Alex Yatsenko on 21.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import Foundation

struct Concentration {
    
    private enum Points: Int {
        case matchBonus = 20
        case missMatchPenalty = 10
    }
    
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    private var seenCards: Set<Int> = []
    private var dateClick: Date?
    private var timePenalty: Int {
        return min(-Int(dateClick?.timeIntervalSinceNow ?? 0), Points.missMatchPenalty.rawValue)
    }
    private var indexOFOneAndOnlyFacedUpCards: Int? {
        get {
            let facedUpCardIndices = cards.indices.filter { cards[$0].isFacedUp }
            return facedUpCardIndices.count == 1 ? facedUpCardIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func resetGame() {
        flipCount = 0
        score = 0
        for index in cards.indices {
            cards[index].isFacedUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not valid for cards")
        guard !cards[index].isMatched else { return }
        
        if let matchedIndex = indexOFOneAndOnlyFacedUpCards, matchedIndex != index {
            if cards[matchedIndex] == cards[index] {
                cards[matchedIndex].isMatched = true
                cards[index].isMatched = true
                score += Points.matchBonus.rawValue
            } else {
                if seenCards.contains(index) {
                    score -= Points.missMatchPenalty.rawValue
                }
                seenCards.insert(index)
                seenCards.insert(matchedIndex)
            }
            score -= timePenalty
            cards[index].isFacedUp = true
        } else {
            indexOFOneAndOnlyFacedUpCards = index
        }
        flipCount += 1
        dateClick = Date()
    }
    
}
