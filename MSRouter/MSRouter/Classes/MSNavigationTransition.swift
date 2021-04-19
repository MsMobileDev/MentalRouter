//
//  MSNavigationTransition.swift
//  MSRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import UIKit

public struct MSNavigationTransition {
    public var presented: UIViewControllerAnimatedTransitioning?
    public var dismissed: UIViewControllerAnimatedTransitioning?
    
    public init(presented: UIViewControllerAnimatedTransitioning?,
                dismissed: UIViewControllerAnimatedTransitioning?) {
        self.presented = presented
        self.dismissed = dismissed
    }
}
