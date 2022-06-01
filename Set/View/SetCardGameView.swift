//
//  SetCardGrid.swift
//  Set
//
//  Created by Sviat on 29.04.2022.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel = SetCardGame()
    @Namespace private var animatingDealCards
    @State var shouldDelay = true
    
    var body: some View {
                VStack {
                    buttonNewGame
                    mainPlayZone
                    HStack(alignment: .top){
                            deck
                            Spacer()
                            sets
                        }
                }
                .padding()
        .background(Color.blue.edgesIgnoringSafeArea(.all).opacity(0.3))
        
    }
    
    var buttonNewGame: some View {
        Button ("New Game"){
            withAnimation(.easeInOut(duration: 4)){
                viewModel.newGame()
            }
        }
            .padding(.horizontal)
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.bordered)
    }
    
    private func zIndex(of card: SetCardGame.Card)-> Double {
        -Double(viewModel.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func offsetXOfCard(for card: SetCardGame.Card)-> CGFloat {
        var x: CGFloat = 0
        if let index = viewModel.deck.firstIndex(where: { $0.id == card.id }) {
            x = -CGFloat(index * 10)
        }
        return x
    }
    
    private func offsetYOfCard(for card: SetCardGame.Card)-> CGFloat {
        var y: CGFloat = 0
        if let index = viewModel.deck.firstIndex(where: { $0.id == card.id }) {
//            y = -1 / 2 * CGFloat(index * 1)
            y = 0
        }
        return y
    }
    
    private var cardTransitionDelay: Double = 2
    
    private func transitionDelay(card: SetCardGame.Card)-> Double {
        guard shouldDelay else { return 0 }
        return Double(viewModel.deck.firstIndex(where: { $0.id == card.id} )!) * cardTransitionDelay
    }
    
    
    var mainPlayZone: some View {
        Grid(items: viewModel.cards, aspectRatio: 3/2){ card in
        CardView(card: card, setting: $viewModel.setting)
                .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                .matchedGeometryEffect(id: card.id, in: animatingDealCards)
                .zIndex(zIndex(of: card))
                .padding(3)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)){
                    viewModel.choose(card: card)
                    }
            }
        }
    }
    
    
    var deck: some View {
        VStack {
            ZStack{
                ForEach(viewModel.deck) { card in
            CardView(card: card, setting: $viewModel.setting)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .matchedGeometryEffect(id: card.id, in: animatingDealCards)
                    .zIndex(zIndex(of: card))
                    .offset(x: offsetXOfCard(for: card), y: offsetYOfCard(for: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1).delay(transitionDelay(card: card))) {
                                    viewModel.deal()
                                DispatchQueue.main.async {
                                    shouldDelay = false
                                }
                            }
                        }
                    }
                    .padding(3)
                }
            .frame(width: 90, height: 60)

            
            
            Group{
                Text("Deck: \(viewModel.deck.count)")
                .font(.headline)
                Text(viewModel.cards.count == 0
                     ? "Click to start"
                     : "\(viewModel.leftNumberOfDealing) free deals left")
                .font(.subheadline)
            }
            .foregroundColor(Color.gray)
                
        }
    }


    var sets: some View {
        
        VStack {
            ZStack{
                ForEach(viewModel.basket) { card in
            CardView(card: card, setting: $viewModel.setting)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))

            }
            .padding(3)
            }
                .frame(width: 90, height: 60)
                
                Text("Total sets: \(viewModel.basket.count / 3)")
                    .font(.headline)
                    .foregroundColor(Color.gray)
               
        }
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
