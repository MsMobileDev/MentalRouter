//
//  MentalRouterProtocol.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

/// Local router protocol
/// Implement this protocol in local router for current screen or module
public protocol MentalRouterProtocol {
    associatedtype MentalRoutingDestination
    
    /// This methods navigates to specified destination with specified presentation style
    ///
    /// - Parameters:
    ///     - destination: MentalRoutingDestination
    ///     - presentationStyle: MentalPresentationStyle
    ///
    /// Call this method to navigate to view controller or SwiftUI view from MentalRoutingDestination with selected MentalPresentationStyle.
    ///
    func route(destination: MentalRoutingDestination, presentationStyle: MentalPresentationStyle)
    
    /// This method rolls back top screen in the navigation stack.
    /// If try to roll back the first screen from the navigation stack, the fatal error will happen.
    ///
    func rollBack()
}

public extension MentalRouterProtocol {
    func rollBack() {
        MentalRouter.default.rollBack()
    }
}
