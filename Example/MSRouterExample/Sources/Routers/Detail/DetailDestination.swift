//
//  DetailDestination.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI
import MSRouter

enum DetailDestination: MSRoutingDestinationProtocol {
    case detailView(color: UIColor)
}

// MARK: RoutingViewProviderProtocol
extension DetailDestination: MSRoutingViewProviderProtocol {
    var destinationView: AnyView {
        switch self {
        case let .detailView(color):
            let viewModel = DetailViewModel(color: color)
            return DetailView(viewModel: viewModel).castToAnyView()
        }
    }
}
