//
//  MSPresentingView.swift
//  MSRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import SwiftUI

/// Enum respresents the prossible ways of wrapping SwiftUI view in controller
public enum MSPresentingView {
    /// This wrapper put AnyView in UIHostingViewController
    ///
    /// - Parameters:
    ///     - rootView: AnyView
    ///
    case viewController(_ rootView: AnyView)
    
    /// This wrapper put result of MSPresentingView in navigation controller
    /// - Parameters:
    ///     - view: MSPresentingView
    ///
    indirect case navigationController(_ view: MSPresentingView)
}
