//
//  MentalRoutingViewProviderProtocol.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

/// Protocol for providing AnyView as a destination for transition
/// Implement this protocol in MentalRoutingDestinationProtocol's subscriber to provide AnyView as a destination for result view controller
///
public protocol MentalRoutingViewProviderProtocol {
    var destinationView: AnyView { get }
}
