//
//  MentalPresentingViewController.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit

/// Enum respresents the prossible ways of wrapping UIViewController in a different controller
public enum MentalPresentingViewController {
    /// This wrapper left origin UIViewController without nay changes
    ///
    /// - Parameters:
    ///     - rootView: UIViewController
    ///
    case viewController(_ controller: UIViewController)
    
    /// This wrapper put result of MentalPresentingView in navigation controller
    /// - Parameters:
    ///     - view: MentalPresentingViewController
    ///
    indirect case navigationController(_ controller: MentalPresentingViewController)
}
