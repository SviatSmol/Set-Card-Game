//
//  SetCardGrid.swift
//  Set
//
//  Created by Sviat on 29.04.2022.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel = SetCardGame()
    
    var body: some View {
                VStack {
                    mainPlayZone
                }
                .padding()
                .background(Color.blue.edgesIgnoringSafeArea(.all).opacity(0.3))
        
    }

    
    var mainPlayZone: some View {
        Grid(items: viewModel.cards, aspectRatio: 3/2){ card in
        CardView(card: card, setting: $viewModel.setting)
                .padding(3)
                .onTapGesture { viewModel.choose(card: card) }
        }
        .onAppear { viewModel.deal() }
    }
}




struct CardView: View {
    var card: SetGame<SetCard>.Card
    var colorOfBorder: [Color] = [.blue, .red, .yellow]
    @Binding var setting: Setting
    
    var body: some View {
        if card.isSelected || !card.isMatched {
            SetCardView(card: card.content, setting: setting)
                .background(Color.white)
                .cornerRadius(cornerRadius)
                .overlay(
                    ZStack{
                RoundedRectangle( cornerRadius: cornerRadius)
                        .foregroundColor(highlightColor()).opacity(0.05)
                    RoundedRectangle( cornerRadius: cornerRadius)
                            .stroke(highlightColor(), lineWidth: borderLineWidth).opacity(0.7)
                    })
        }
    }
    // MARK: drawing functions and constants
    
    private let cornerRadius: CGFloat = 10.0
    private let borderLineWidth: CGFloat = 1
    
    private func highlightColor()-> Color {
        var color = Color.gray.opacity(0.3)
        if card.isSelected {
            if card.isMatched{
            color = colorOfBorder[0]
        } else if card.isNotMatched {
            color = colorOfBorder[1]
        } else {
            color = colorOfBorder[2]
        }
        }
        return color
    }
}

struct SetCardGrid_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView()
            .previewInterfaceOrientation(.portrait)
    }
}
