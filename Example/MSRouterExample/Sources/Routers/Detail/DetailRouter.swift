//
//  DetailRouter.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation
import MSRouter

final class DetailRouter {
    private let router: MSRouter
    
    init(router: MSRouter) {
        self.router = router
    }
}

// MARK: RouterProtocol
extension DetailRouter: MSRouterProtocol {
    typealias MSRoutingDestination = MSRoutingDestinationProtocol & MSRoutingViewProviderProtocol
    
    func route(destination: MSRoutingDestination, presentationStyle: MSPresentationStyle) {
        let view = destination.destinationView
        let viewController = router.buildViewController(presentingView: .viewController(view))
        
        // Configure navigationItem here if it needed
        
        router.navigate(viewController: viewController, presentationStyle: presentationStyle)
    }
}
