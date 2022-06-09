//
//  SetGame.swift
//  Set
//
//  Created by Sviat on 27.04.2022.
//

import Foundation

protocol Matchable {
    static func match(cards: [Self])-> Bool
}



struct SetGame<CardContent> where CardContent: Matchable {
    
    private (set) var cards = [Card]()
    private (set) var deck = [Card]()

    
    let numberOfCardsToMatch = 3
    var numberOfCardsStart: Int
    var numberHint = 0
    
    private var selectedIndices: [Int] {cards.indices.filter {cards[$0].isSelected}}
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isSelected,
           !cards[chosenIndex].isMatched {
            //----------------selectedCards count = 2------------------
            if selectedIndices.count == 2 {
                cards[chosenIndex].isSelected = true
                if CardContent.match(cards: selectedIndices.map {cards[$0].content}){
                    //---------------matched----------------
                    for index in selectedIndices {
                        cards[index].isMatched = true
                    }
                    //------------- not matched--------------
                }else{
                    for index in selectedIndices {
                        cards[index].isNotMatched = true
                    }
                }
            }else{
                //----------------selected cards count 0, 1, 3
                if selectedIndices.count == 1 || selectedIndices.count == 0 {
                    cards[chosenIndex].isSelected = true
                }else{
                    changeCards()
                    onlySelectedCards(chosenIndex)
                }
            }
        }
        // if card is Chosen but player want to choose another card
        else if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            cards[chosenIndex].isSelected,
            !cards[chosenIndex].isMatched,
            !cards[chosenIndex].isNotMatched{
                        cards[chosenIndex].isSelected = false
                            }
    }
    
    private mutating func onlySelectedCards (_ onlyIndex: Int) {
        for index in cards.indices {
            cards[index].isSelected = index == onlyIndex
            cards[index].isNotMatched = false
        }
    }
    
    var matchedIndices: [Int] { cards.indices.filter {cards[$0].isSelected && cards[$0].isMatched }}
   
    
    mutating func changeCards() {
        guard matchedIndices.count == numberOfCardsToMatch else { return }
        numberHint = 0
        let replaceIndices = matchedIndices
        if deck.count >= numberOfCardsToMatch && cards.count == numberOfCardsStart{
            //---------replace matched cards---------
            for index in replaceIndices{
                cards.insert(deck.remove(at: 0), at: index)
            }
        } else {
            //--------remove matched cards----------
            cards = cards.enumerated()
                .filter { !replaceIndices.contains($0.offset) }
                .map { $0.element }
        }
    }
    
    init(numberOfCardsStart: Int,
         numberOfCardsInDeck: Int,
         cardContentFactory: (Int)-> CardContent){
        cards = [Card]()
        deck = [Card]()
        
        self.numberOfCardsStart = numberOfCardsStart
        for i in 0..<numberOfCardsInDeck{
            let content = cardContentFactory(i)
            deck.append(Card.init(content: content, id: i))
        }
        deck.shuffle()
    }


    
    mutating func deal(_ numberOfCards: Int? = nil ) {
      let n = numberOfCards  ?? numberOfCardsStart
        for _ in 0..<n {
            cards.append(deck.remove(at: 0))
        }
    }
    
    var hints: [[Int]] {
        var hints = [[Int]]()
        
        if cards.count > 2 {
            for i in 0..<cards.count - 2 {
                for j in (i+1)..<cards.count - 1 {
                    for k in (j+2)..<cards.count {
                        let checkList = [cards[i], cards[j], cards[k]]
                        if CardContent.match(cards: checkList.map { $0.content }) {
                            hints.append([i, j, k])
                        }
                    }
                }
            }
        }
        return hints
    }
    
    
    mutating func hint() {
        if hints.count > 0 && numberHint < hints.count {
            for index in hints[numberHint]{
                cards[index].isHint = true
            }
            numberHint += 1
            numberHint = numberHint < hints.count ? numberHint : 0
        }
    }
    
    mutating func deHint() {
        if hints.count > 0 {
            for index in 0..<cards.count {
                cards[index].isHint = false
            }
        }
    }
    
    
    struct Card: Identifiable {
        var isSelected: Bool = false
        var isMatched: Bool = false
        var isNotMatched: Bool = false
        var content: CardContent
        var id: Int
        var isHint: Bool = false
    }
    
}
