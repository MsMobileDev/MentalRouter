//
//  DetailRouter.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

final class DetailRouter: RouterProtocol {
    typealias RoutingDestination = RoutingDestinationProtocol & RoutingViewProviderProtocol
    
    private let router: Router = Application.shared.router
    
    func route(destination: RoutingDestination) {
        let view = destination.destinationView
        router.navigate(view: view)
    }
}
