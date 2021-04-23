//
//  DetailDestination.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import SwiftUI
import MentalRouter

enum DetailDestination: MentalRoutingDestinationProtocol {
    case detailView(color: UIColor)
}

// MARK: RoutingViewProviderProtocol
extension DetailDestination: MentalRoutingViewProviderProtocol {
    var destinationView: AnyView {
        switch self {
        case let .detailView(color):
            let viewModel = DetailViewModel(color: color)
            return DetailView(viewModel: viewModel).castToAnyView()
        }
    }
}
