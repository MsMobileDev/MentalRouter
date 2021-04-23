//
//  MentalPresentationStyle.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import UIKit

/// Enum represents presentation style of transition from one UIViewController to another one
public enum MentalPresentationStyle {
    /// Push a screen to the navigation stack with right-to-left movment animated
    case push
    
    /// Present a screen with the specified presentation and transition styles
    ///
    /// - Parameters:
    ///     - presentationStyle: UIModalPresentationStyle
    ///     - transitionStyle: UIModalTransitionStyle
    ///
    case present(presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    
    /// Replace current root controller with a provided one
    case replaceRoot
    
    /// Present a screen with the specified custom transition
    ///
    /// - Parameters:
    ///     - transition: MentalNavigationTransition
    ///
    case custom(transition: MentalNavigationTransition)
}
