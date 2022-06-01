//
//  Diamond.swift
//  Set
//
//  Created by Sviat on 26.04.2022.
//

import SwiftUI

struct Diamond: Shape{

    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let bigDiagonal = min(rect.width, rect.height) / 1.1
        let smallDiagonal = bigDiagonal / 2
        
        let pointA = CGPoint(
            x: center.x,
            y: center.y + bigDiagonal
        )
        
        let pointB = CGPoint(
            x: center.x - smallDiagonal,
            y: center.y
        )
        
        let pointC = CGPoint(
            x: center.x,
            y: center.y - bigDiagonal
        )
        
        let pointD = CGPoint(
            x: center.x + smallDiagonal,
            y: center.y
        )
        
        var p = Path()
        
        p.move(to: pointA)
        p.addLine(to: pointB)
        p.addLine(to: pointC)
        p.addLine(to: pointD)
        p.addLine(to: pointA)
        
        return p
    }
}
