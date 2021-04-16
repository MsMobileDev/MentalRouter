//
//  TransitionHandler.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 16.04.2021.
//

import UIKit

struct NavigationTransition {
    var presented: UIViewControllerAnimatedTransitioning?
    var dismissed: UIViewControllerAnimatedTransitioning?
}

final class ScaleTransition: NSObject {
    var scale: CGFloat
    var duration: TimeInterval
    
    init(scale: CGFloat, duration: TimeInterval) {
        self.scale = scale
        self.duration = duration
    }
}

extension ScaleTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
            return transitionContext.completeTransition(false)
        }
        
        toViewController.view.frame = fromViewController.view.bounds
        
        let containerView = transitionContext.containerView
        containerView.addSubview(self.scale >= 1 ? toViewController.view : fromViewController.view)
        
        // TODO: implement
        
        transitionContext.completeTransition(true)
    }
}

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
