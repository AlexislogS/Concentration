//
//  Theme.swift
//  Concentration
//
//  Created by Alex Yatsenko on 22.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import UIKit

struct Theme {
    
    let emojis: String
    let name: String
    let deckColor: UIColor
    let backgroundColor: UIColor
    
    static var themes = [
        Theme(emojis: "🍏🍓🍉🍇🍒🍌🥝🍆🍑🍋",
              name: "Fruits",
              deckColor: .lightGray,
              backgroundColor: .systemPink),
        Theme(emojis: "⚽️🏄‍♂️🏑🏓🚴‍♂️🥋🎸🎯🎮🎹🎲",
              name: "Activity",
              deckColor: .darkGray,
              backgroundColor: .systemGreen),
        Theme(emojis: "🐶🐭🦊🦋🐢🐸🐵🐞🐿🐇🐯",
              name: "Animals",
              deckColor: .systemYellow,
              backgroundColor: .systemRed),
        Theme(emojis: "🎅🎉🦌⛪️🌟❄️⛄️🎄🎁🔔🕯",
              name: "Christmas",
              deckColor: .systemBlue,
              backgroundColor: .lightGray),
        Theme(emojis: "🚗🚓🚚🏍✈️🚜🚎🚲🚂🛴",
              name: "Transport",
              deckColor: .brown,
              backgroundColor: .lightGray),
        Theme(emojis: "💀👻👽🙀🦇🕷🕸🎃🎭😈⚰",
              name: "Halloween",
              deckColor: .orange,
              backgroundColor: .black)
    ]
    
    
    
}
