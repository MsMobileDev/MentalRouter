//
//  DetailRouter.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

final class DetailRouter {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
}

// MARK: RouterProtocol
extension DetailRouter: RouterProtocol {
    typealias RoutingDestination = RoutingDestinationProtocol & RoutingViewProviderProtocol
    
    func route(destination: RoutingDestination, presentationStyle: PresentationStyle) {
        let view = destination.destinationView
        let viewController = router.buildViewController(presentingView: .viewController(view))
        
        // Configure navigationItem here if it needed
        
        router.navigate(viewController: viewController, presentationStyle: presentationStyle)
    }
}
