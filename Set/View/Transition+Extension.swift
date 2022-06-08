//
//  Transition+Extension.swift
//  Set
//
//  Created by Sviat on 08.06.2022.
//

import SwiftUI

public extension AnyTransition {
    
    static func cardTransition(size: CGSize)-> AnyTransition {
        let insertion = AnyTransition.offset(flyFrom(for: size))
        let removal = AnyTransition.offset(flyTo(for: size)).combined(with: .scale(scale: 0.5))
                              
        return .asymmetric(insertion: insertion, removal: removal)
    }
                              
    static func flyFrom(for size: CGSize)-> CGSize {
        CGSize(width: 0.0, height: size.height)
    }


    static func flyTo(for size: CGSize)-> CGSize {
        CGSize(width: CGFloat.random(in: -3*size.width...3*size.width),
        height: CGFloat.random(in: -2*size.height...(-size.height)))
    }
}
