//
//  RectModifier.swift
//  MentalRouterExample
//
//  Created by Olga Shilenko on 22.04.2021.
//

import SwiftUI

struct RectModifier: ViewModifier {
    @Binding var frame: CGRect?
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: RectPreferenceKey.self, value: geometry.frame(in: .global))
            }
        )
        .onPreferenceChange(RectPreferenceKey.self) {
            self.frame = $0
        }
    }
}
