//
//  Stadium.swift
//  Set
//
//  Created by Sviat on 26.04.2022.
//

import SwiftUI

struct Stadium: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let heightOfOval = min(rect.width, rect.height)
        let radiusOfTopOfOval = heightOfOval / 2.3
        
        let topCenterOfTopOfOval = CGPoint(
            x: center.x,
            y: center.y + radiusOfTopOfOval
        )
        
        let lowerCenterOfTopOfOval = CGPoint(
            x: center.x,
            y: center.y - radiusOfTopOfOval
        )
        
        let firstAngle = Angle(degrees: 0)
        let secondAngle = Angle(degrees: 0-180)
        
    
        
        let pointA = CGPoint(
            x: center.x - radiusOfTopOfOval,
            y: center.y + radiusOfTopOfOval
        )
        
        let pointB = CGPoint(
            x: center.x - radiusOfTopOfOval,
            y: center.y - radiusOfTopOfOval
        )
        
//        let pointC = CGPoint(
//            x: center.x + radiusOfTopOfOval,
//            y: center.y - radiusOfTopOfOval
//        )
        
        let pointD = CGPoint(
            x: center.x + radiusOfTopOfOval,
            y: center.y + radiusOfTopOfOval
        )
        
        var p = Path()
        
        p.move(to: pointA)
        p.addLine(to: pointB)
        p.addArc(center: topCenterOfTopOfOval,
                 radius: radiusOfTopOfOval,
                 startAngle: secondAngle,
                 endAngle: firstAngle,
                 clockwise: true)
        p.addLine(to: pointD)
        p.addArc(center: lowerCenterOfTopOfOval,
                 radius: radiusOfTopOfOval,
                 startAngle: firstAngle,
                 endAngle: secondAngle,
                 clockwise: true)
        
        return p
    }
}

