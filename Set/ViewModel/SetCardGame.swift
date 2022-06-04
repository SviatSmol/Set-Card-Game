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
}

struct Setting {
    var colorShapes = [Color.green, Color.red, Color.purple]
    var fillShapes = [FillInSet.stroke, .fill, .stripe]
    var shapes = [ShapeInSet.diamond, .squiggle, .stadium]
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
    
    
    // MARK: intents
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func deal() {
        model.deal()
    }
    
//    func deal3() {
//        model.deal3()
//    }
    
    func newGame () {
        model = SetCardGame.createSetGame()
    }
    
   
}
