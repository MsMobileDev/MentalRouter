//
//  TransitionHandler.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 16.04.2021.
//

import UIKit

final class TransitionHandler: NSObject {
    var navigationTransition: NavigationTransition
    
    init(navigationTransition: NavigationTransition) {
        self.navigationTransition = navigationTransition
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension TransitionHandler: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.presented
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return navigationTransition.dismissed
    }
}
