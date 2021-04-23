//
//  MSRoutingViewProviderProtocol.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

/// Protocol for providing AnyView as a destination for transition
/// Implement this protocol in MSRoutingDestinationProtocol's subscriber to provide AnyView as a destination for result view controller
///
public protocol MSRoutingViewProviderProtocol {
    var destinationView: AnyView { get }
}
