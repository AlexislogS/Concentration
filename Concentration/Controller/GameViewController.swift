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
    private var emojiChoices: String!
    private var backgroundColor = UIColor.lightGray
    private var cardDeckColor = UIColor.systemBlue
    private var emoji = [Card:String]()
    private var emojiThemes = Theme.themes
    var initialIndexTheme: Int?
    var indexTheme = 0 {
        didSet {
            emoji = [Card:String]()
            titleLabel.text = emojiThemes[indexTheme].name
            emojiChoices = emojiThemes[indexTheme].emojis
            backgroundColor = emojiThemes[indexTheme].backgroundColor
            cardDeckColor = emojiThemes[indexTheme].deckColor
            
            updateAppearance()
            updateViewFromModel()
        }
    }
    var numberOfPairOFCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var randomThemeButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton! {
        didSet {
            updateStartButton()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Wrong card")
        }
    }
    
    @IBAction private func startNewGame() {
        game.resetGame()
        updateViewFromModel()
    }
    
    @IBAction private func randomGame() {
        indexTheme = Int.random(in: 0..<emojiThemes.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = initialIndexTheme ?? Int.random(in: 0..<emojiThemes.count)
    }
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardDeckColor
        scoreLabel.textColor = cardDeckColor
        titleLabel.textColor = cardDeckColor
        startButton.setTitleColor(backgroundColor, for: .normal)
        startButton.backgroundColor = cardDeckColor
        randomThemeButton.tintColor = cardDeckColor
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
    
    private func updateStartButton() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.black
        ]
        let attributedString = NSAttributedString(string: "START", attributes: attributes)
        startButton.setAttributedTitle(attributedString, for: .normal)
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


