//
//  Card.swift
//  Concentration
//
//  Created by Alex Yatsenko on 21.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    private var identifier: Int
    var isFacedUp = false
    var isMatched = false
    
    private static var identifierFactory = 0
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}
