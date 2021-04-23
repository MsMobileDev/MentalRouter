//
//  MSTransitionHandler.swift
//  MSRouter
//
//  Created by Olga Shilenko on 16.04.2021.
//

import UIKit

/// Class provides transition handler
public final class MSTransitionHandler: NSObject {
    /// Navigation transition
    public var navigationTransition: MSNavigationTransition
    
    /// Public initialiser of MSTransitionHandler class
    ///
    ///  - Parameters:
    ///     - navigationTransition: MSNavigationTransition
    ///
    public init(navigationTransition: MSNavigationTransition) {
        self.navigationTransition = navigationTransition
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension MSTransitionHandler: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.presented
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.dismissed
    }
}
