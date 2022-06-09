//
//  Drop.swift
//  Set
//
//  Created by Sviat on 09.06.2022.
//

import Foundation

import SwiftUI

struct Drop: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()

        path.move(to: CGPoint(x: rect.size.width/2, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width/2, y: rect.size.height), control: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addQuadCurve(to: CGPoint(x: rect.size.width/2, y: 0), control: CGPoint(x: 0, y: rect.size.height))

            return path
        }
}

struct Drop_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Drop().stroked()
            Drop().stripped()
            Drop().filled()
        }
    }
}
