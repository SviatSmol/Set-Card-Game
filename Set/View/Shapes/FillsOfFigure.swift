//
//  FillsOfFigures.swift
//  Set
//
//  Created by Sviat on 26.04.2022.
//

import SwiftUI



struct Stripped: Shape{
    func path(in rect: CGRect) -> Path {
    
        let spaceBetweenStripeLine: CGFloat = 3
        
        let start = CGPoint(x: rect.minX, y: rect.minY)
        
        var p = Path()
        
        p.move(to: start)
    
        while p.currentPoint!.y < rect.maxY{
            p.addLine(to: CGPoint(x: rect.maxX, y: p.currentPoint!.y))
            p.move(to: CGPoint(x: rect.minX - 10, y: p.currentPoint!.y + spaceBetweenStripeLine))
        }
        
        return p
    }
}


extension Shape {
    func stripped(_ lineWidth: CGFloat = 1)-> some View {
        ZStack{
            Stripped().stroke(lineWidth: 1).clipShape(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func stroked(_ lineWidth: CGFloat = 1)-> some View {
            self.stroke(lineWidth: lineWidth)
    }
    
    func filled(_ lineWidth: CGFloat = 1)-> some View {
            self.fill()
    }
}
