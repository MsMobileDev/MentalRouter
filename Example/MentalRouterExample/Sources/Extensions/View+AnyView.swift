//
//  View+AnyView.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

extension View {
    func castToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    func subscribe(onFrameChange rect: Binding<CGRect?>) -> some View {
        self.modifier(RectModifier(frame: rect))
    }
}
