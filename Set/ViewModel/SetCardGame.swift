//
//  SetCardGame.swift
//  Set
//
//  Created by Sviat on 28.04.2022.
//

import SwiftUI


enum FillInSet: Int, CaseIterable {
    case stroke = 1
    case fill
    case stripe
}

enum ShapeInSet: Int, CaseIterable {
    case diamond = 1
    case squiggle
    case stadium
    case drop
}

struct Setting {
    var colorShapes = [Color.green, Color.red, Color.purple]
    var fillShapes = [FillInSet.stroke, .fill, .stripe]
    //possible: .diamond, .squiggle, .stadium, .drop
    var shapes = [ShapeInSet.diamond, .drop, .stadium]
    var colorHint: Color = .red
    var colorOfBorder: [Color] = [.blue, .red, .yellow]
}

class SetCardGame: ObservableObject {
    
    typealias Card = SetGame<SetCard>.Card
    
    @Published private var model: SetGame<SetCard> = SetCardGame.createSetGame()
    
    static func createSetGame()-> SetGame<SetCard> {
        SetGame(numberOfCardsStart: numberOfCardsStart, numberOfCardsInDeck: deck.cards.count) { index in deck.cards[index] }
    }
    
    static var numberOfCardsStart = 15
    static private var deck = SetCardDeck()
    
    var setting = Setting()

    
    
    // MARK: access to model
    
    var cards: Array<Card> {
        model.cards
    }
    
    var deck : Array<Card> {
        model.deck
    }
    
    var numberHint: String {
        "Hints: \(model.hints.count) / \(model.numberHint + 1)"
    }
    
    
    // MARK: intents
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func deal() {
        model.deal()
    }
    
    func deal3() {
        if model.matchedIndices.count == 3 {
            model.changeCards()
        }else{
            model.deal(3)
        }
    }
    
    func resetGame () {
        model = SetCardGame.createSetGame()
    }
    
    func hint() {
        model.hint()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.model.deHint()
        }
    }
    
   
}
