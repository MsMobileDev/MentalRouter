//
//  View+AnyView.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

extension View {
    func castToAnyView() -> AnyView {
        return AnyView(self)
    }
}
