//
//  MentalTransitionHandler.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 16.04.2021.
//

import UIKit

/// Class provides transition handler
public final class MentalTransitionHandler: NSObject {
    /// Navigation transition
    public var navigationTransition: MentalNavigationTransition
    
    /// Public initialiser of MentalTransitionHandler class
    ///
    ///  - Parameters:
    ///     - navigationTransition: MentalNavigationTransition
    ///
    public init(navigationTransition: MentalNavigationTransition) {
        self.navigationTransition = navigationTransition
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension MentalTransitionHandler: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.presented
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.dismissed
    }
}
