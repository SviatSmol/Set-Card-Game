//
//  SetCardGrid.swift
//  Set
//
//  Created by Sviat on 29.04.2022.
//

import SwiftUI

struct SetCardGameView: View {
    @StateObject var viewModel = SetCardGame()
    @State var shouldDelay = true

    var body: some View {
                VStack {
                    GameView(viewModel: viewModel, shouldDelay: $shouldDelay).onAppear { deal() }
                    HStack(spacing: 50) {
//                        Text("Deck:\( viewModel.deck.count )")
                        Button(viewModel.numberHint){ viewModel.hint() }
                        Button("Deal+3"){ deal3() }.disabled(viewModel.cards.count == 0)
                        Button("New Game"){ newGame() }
                    }
                }
                .padding()
                .background(Color.blue.edgesIgnoringSafeArea(.all).opacity(0.3))
        
    }
    
    
    private func deal() {
        viewModel.deal()
        DispatchQueue.main.async {
            shouldDelay = false
        }
    }
    
    private func deal3() {
        shouldDelay = true
        viewModel.deal3()
        DispatchQueue.main.async {
            shouldDelay = false
        }
    }
    
    private func newGame() {
        viewModel.resetGame()
        shouldDelay = true
        deal()
    }
}


struct GameView: View {
    @ObservedObject var viewModel: SetCardGame
    @Binding var shouldDelay: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Grid(items: viewModel.cards, aspectRatio: 3/2){ card in
                CardView(card: card, setting: $viewModel.setting)
                    .transition(.cardTransition(size: geometry.size))
                    .animation(.easeInOut(duration: 1.00).delay(transitionDelay(card: card)))
                    .padding(3)
                    .onTapGesture {
                        viewModel.choose(card: card)
                }
            }
        }
    }
    
    private func transitionDelay(card: SetCardGame.Card)-> Double {
        guard shouldDelay else { return 0 }
        return Double(viewModel.cards.firstIndex(where: {$0.id == card.id})!) * 0.15
    }
}

struct CardView: View {
    var card: SetGame<SetCard>.Card
    var colorOfBorder: [Color] = [.blue, .red, .yellow]
    var colorHint: Color = .red
    @Binding var setting: Setting
    
    var body: some View {
        if card.isSelected || !card.isMatched {
            SetCardView(card: card.content, setting: setting)
                .background(card.isHint ? colorHint.opacity(0.05) : Color.white)
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
