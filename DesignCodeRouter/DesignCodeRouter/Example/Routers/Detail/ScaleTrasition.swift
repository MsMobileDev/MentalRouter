//
//  ScaleTrasition.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import UIKit

final class ScaleTransition: NSObject {
    var scale: CGFloat
    var center: CGPoint
    var duration: TimeInterval
    var delay: TimeInterval
    
    private lazy var fadeDuration: TimeInterval = duration / 3
    
    init(duration: TimeInterval, scale: CGFloat, center: CGPoint, delay: TimeInterval = 0.0) {
        self.scale = min(max(scale, 0.0), 1.0)
        self.center = center
        self.duration = duration
        self.delay = delay
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
        
        let screenView: UIView! = self.scale >= 1 ? toViewController.view : fromViewController.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(screenView)
        
        let initialScale: CGFloat = 1 - scale
        let fadeStartTime: TimeInterval = (1 - Double(self.scale)) * (1 - fadeDuration / duration)
        let initialCenterTranslation: CGPoint = scale == 1.0 ? center - screenView.center : .zero
        let centerTranslation: CGPoint = scale == 1.0 ? .zero : center - screenView.center
        
        screenView.transform = CGAffineTransform.identity
            .translatedBy(x: initialCenterTranslation.x, y: initialCenterTranslation.y)
            .scaledBy(x: initialScale, y: initialScale)
        
        screenView.alpha = 1 - scale
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: self.duration) {
                screenView.transform = CGAffineTransform.identity
                    .translatedBy(x: centerTranslation.x, y: centerTranslation.y)
                    .scaledBy(x: self.scale, y: self.scale)
            }
            
            UIView.addKeyframe(withRelativeStartTime: fadeStartTime, relativeDuration: self.fadeDuration) {
                screenView.alpha = self.scale
            }
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
    }
}

// MARK: Private methods
private extension CGPoint {
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
