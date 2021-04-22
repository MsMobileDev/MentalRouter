//
//  RectPreferenceKey.swift
//  MSRouterExample
//
//  Created by Olga Shilenko on 22.04.2021.
//

import Foundation

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
