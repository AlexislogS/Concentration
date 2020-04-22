//
//  GameViewController.swift
//  Concentration
//
//  Created by Alex Yatsenko on 20.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOFCards)
    var numberOfPairOFCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var indexTheme = 0 {
        didSet {
            emoji = [Card:String]()
            titleLabel.text = emojiThemes[indexTheme].name
            emojiChoices = emojiThemes[indexTheme].emojis
            backgroundColor = emojiThemes[indexTheme].backgroundColor
            cardDeckColor = emojiThemes[indexTheme].deckColor
            
            updateAppearance()
        }
    }
    private var emojiChoices: String!
    private var backgroundColor = UIColor.lightGray
    private var cardDeckColor = UIColor.systemBlue
    private var emoji = [Card:String]()
    private var emojiThemes = Theme.themes
    
    @IBOutlet private weak var startNewButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton! {
        didSet {
            updateStartButton()
        }
    }
    
    private func updateStartButton() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.black
        ]
        let attributedString = NSAttributedString(string: "START", attributes: attributes)
        startButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Wrong card")
        }
    }
    
    @IBAction func startNewGame() {
        indexTheme = Int.random(in: 0..<emojiThemes.count)
        game.resetGame()
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = Int.random(in: 0..<emojiThemes.count)
        updateViewFromModel()
    }
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardDeckColor
        scoreLabel.textColor = cardDeckColor
        titleLabel.textColor = cardDeckColor
        startNewButton.setTitleColor(backgroundColor, for: .normal)
        startNewButton.backgroundColor = cardDeckColor
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : cardDeckColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, !emojiChoices.isEmpty {
            let randomIntIndex = Int.random(in: 0..<emojiChoices.count)
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: randomIntIndex)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}


