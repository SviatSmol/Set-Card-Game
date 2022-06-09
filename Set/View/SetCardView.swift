//
//  ContentView.swift
//  Set
//
//  Created by Sviat on 22.04.2022.
//

import SwiftUI

struct SetCardView: View {
    
    var card: SetCard
    var setting: Setting
    
    var colorsShapes: [Color] = [.green, .red, .blue]
    
    var body: some View {
       
            GeometryReader{ geometry in
                HStack{
                    Spacer()
                    ForEach(0..<card.number.rawValue, id: \.self ) { index in
                        cardShape().frame(width: geometry.size.width/4)
                    }
                    Spacer()
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height,
                    alignment: .center
                )
            }
                .padding()
                .foregroundColor(colorsShapes[card.color.rawValue - 1])
                .aspectRatio(CGFloat(3.0/2.0), contentMode: .fit)
        }
                
    
    @ViewBuilder private func cardShape()-> some View {
        ZStack{
            switch ShapeInSet(card: card) {
            case .diamond: shapeFill(shape: Diamond())
            case .squiggle: shapeFill(shape: Squiggle())
            case .stadium: shapeFill(shape: Stadium())
            case .drop: shapeFill(shape: Drop())
            }
        }
    }
    
    private func ShapeInSet(card: SetCard)-> ShapeInSet {
        setting.shapes[card.fill.rawValue - 1]
    }
    
        
    @ViewBuilder private func shapeFill<SetShape>(shape: SetShape)-> some View where SetShape: Shape {
            ZStack{
                switch FillInSet(card: card) {
                    case .stroke: shape.stroked()
                    case .fill: shape.filled()
                    case .stripe: shape.stripped()
                }
            }
        }
    
    private func FillInSet(card: SetCard)-> FillInSet {
        setting.fillShapes[card.shape.rawValue - 1]
    }
                
    }
                













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardView(card: SetCard (number:.v1, color: .v3, shape: .v1, fill: .v3), setting: Setting())
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 3))
        .padding()
    }
}


