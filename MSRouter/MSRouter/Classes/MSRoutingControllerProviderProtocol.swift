//
//  MSRoutingControllerProviderProtocol.swift
//  MSRouter
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit

/// Protocol for providing destination UIViewController for transition
/// Implement this protocol in MSRoutingDestinationProtocol's subscriber to provide UIViewController as a destination view controller
///
public protocol MSRoutingControllerProviderProtocol {
    /// View controller for destination screen
    var viewController: UIViewController { get }
}
