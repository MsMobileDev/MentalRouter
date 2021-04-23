//
//  MSRouterProtocol.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

/// Local router protocol
/// Implement this protocol in local router for current screen or module
public protocol MSRouterProtocol {
    associatedtype MSRoutingDestination
    
    /// This methods navigates to specified destination with specified presentation style
    ///
    /// - Parameters:
    ///     - destination: MSRoutingDestination
    ///     - presentationStyle: MSPresentationStyle
    ///
    /// Call this method to navigate to view controller or SwiftUI view from MSRoutingDestination with selected MSPresentationStyle.
    ///
    func route(destination: MSRoutingDestination, presentationStyle: MSPresentationStyle)
    
    /// This method rolls back top screen in the navigation stack.
    /// If try to roll back the first screen from the navigation stack, the fatal error will happen.
    ///
    func rollBack()
}

public extension MSRouterProtocol {
    func rollBack() {
        MSRouter.default.rollBack()
    }
}
