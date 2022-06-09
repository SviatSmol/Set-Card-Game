//
//  SetCard.swift
//  Set
//
//  Created by Sviat on 26.04.2022.
//

import Foundation


struct SetCard: CustomStringConvertible, Matchable {
    
    let number: Variant
    let color: Variant
    let shape: Variant
    let fill: Variant
    
    var description: String {return "\(number)-\(color)-\(shape)-\(fill)"}
    
    enum Variant: Int, CaseIterable, CustomStringConvertible {
        
        case v1 = 1
        case v2
        case v3
        
        var description: String { return String(self.rawValue)}
    }


    
    static func match(cards: [SetCard]) -> Bool {
        guard cards.count == 3 else { return false }
        let sum = [
        cards.reduce(0, { $0 + $1.number.rawValue }),
        cards.reduce(0, { $0 + $1.color.rawValue }),
        cards.reduce(0, { $0 + $1.shape.rawValue }),
        cards.reduce(0, { $0 + $1.fill.rawValue })
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
    

}
