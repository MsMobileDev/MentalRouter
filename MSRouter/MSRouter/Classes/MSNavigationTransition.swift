//
//  MSNavigationTransition.swift
//  MSRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import UIKit

/// Struct represents transitons for presented UIViewController
public struct MSNavigationTransition {
    /// Animated transitioning for presented UIViewController in custom transition.
    /// If the value of parameter is nil, modal presentation of UIViewController happens without animation
    public var presented: UIViewControllerAnimatedTransitioning?
    
    /// Animated transitioning for dismissed UIViewController in custom transition.
    /// If the value of parameter is nil, dismissing of UIViewController happens without animation
    public var dismissed: UIViewControllerAnimatedTransitioning?
    
    /// Public initialiser of MSNavigationTransition class
    ///
    /// - Parameters:
    ///
    ///     - presented: UIViewControllerAnimatedTransitioning for presentation in custom transition
    ///     - dismissed: UIViewControllerAnimatedTransitioning for dismissing in custom transition
    ///
    public init(presented: UIViewControllerAnimatedTransitioning?,
                dismissed: UIViewControllerAnimatedTransitioning?) {
        self.presented = presented
        self.dismissed = dismissed
    }
}
