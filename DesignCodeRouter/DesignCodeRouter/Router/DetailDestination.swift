//
//  DetailDestination.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI

enum DetailDestination: RoutingDestinationProtocol {
    case detailView(color: UIColor)
}

// MARK: RoutingViewProviderProtocol
extension DetailDestination: RoutingViewProviderProtocol {
    var destinationView: AnyView {
        switch self {
        case let .detailView(color):
            return DetailView(color: color).castToAnyView()
        }
    }
}
