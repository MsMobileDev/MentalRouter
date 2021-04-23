//
//  MSPresentingViewController.swift
//  MSRouter
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit

/// Enum respresents the prossible ways of wrapping UIViewController in a different controller
public enum MSPresentingViewController {
    /// This wrapper left origin UIViewController without nay changes
    ///
    /// - Parameters:
    ///     - rootView: UIViewController
    ///
    case viewController(_ controller: UIViewController)
    
    /// This wrapper put result of MSPresentingView in navigation controller
    /// - Parameters:
    ///     - view: MSPresentingViewController
    ///
    indirect case navigationController(_ controller: MSPresentingViewController)
}
