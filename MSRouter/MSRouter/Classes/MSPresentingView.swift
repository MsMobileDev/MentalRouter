//
//  MSPresentingView.swift
//  MSRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import SwiftUI

public enum MSPresentingView {
    case viewController(_ rootView: AnyView)
    indirect case navigationController(_ view: MSPresentingView)
}
