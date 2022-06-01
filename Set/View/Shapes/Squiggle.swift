//
//  Squiggle.swift
//  Set
//
//  Created by Sviat on 26.04.2022.
//

import SwiftUI

struct Squiggle: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = min(rect.width, rect.height)
        let halfWidth = width / 1.1
        let quarterWidth = width / 4


        let startOfWave1 = CGPoint(
            x: center.x + quarterWidth,
            y: center.y + halfWidth
        )

        let endOfWave1 = CGPoint(
            x: center.x + quarterWidth,
            y: center.y - halfWidth
        )

        let controlPointOne1 = CGPoint(
            x: center.x + halfWidth *  0.8,
            y: center.y / 8 + halfWidth
        )

        let controlPointSecond1 = CGPoint(
            x: center.x - quarterWidth / 1.9,
            y: center.y * 1.5 - quarterWidth
        )


        let startOfWave2 = CGPoint(
            x: center.x - 5 - quarterWidth,
            y: center.y - halfWidth
        )

        let endOfWave2 = CGPoint(
            x: center.x - 5 - quarterWidth,
            y: center.y + halfWidth
        )

        let controlPointOne2 = CGPoint(
            x: center.x - 5 - halfWidth / 1.9,
            y: center.y * 2 - halfWidth
        )

        let controlPointSecond2 = CGPoint(
            x: center.x - 5 + quarterWidth * 1.1,
            y: center.y / 2 + quarterWidth
        )

        var p = Path()

        p.move(to: startOfWave1)
        p.addCurve(to: endOfWave1, control1: controlPointOne1, control2: controlPointSecond1)
        p.addLine(to: startOfWave2)
        p.addCurve(to: endOfWave2, control1: controlPointOne2, control2: controlPointSecond2)
        p.addLine(to: startOfWave1)

        return p
    }
}
