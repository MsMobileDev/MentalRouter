//
//  MentalPresentingView.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import SwiftUI

/// Enum respresents the prossible ways of wrapping SwiftUI view in controller
public enum MentalPresentingView {
    /// This wrapper put AnyView in UIHostingViewController
    ///
    /// - Parameters:
    ///     - rootView: AnyView
    ///
    case viewController(_ rootView: AnyView)
    
    /// This wrapper put result of MentalPresentingView in navigation controller
    /// - Parameters:
    ///     - view: MentalPresentingView
    ///
    indirect case navigationController(_ view: MentalPresentingView)
}
