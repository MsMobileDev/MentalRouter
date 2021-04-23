//
//  DetailRouter.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation
import MentalRouter

final class DetailRouter {
    private let router: MentalRouter
    
    init(router: MentalRouter) {
        self.router = router
    }
}

// MARK: RouterProtocol
extension DetailRouter: MentalRouterProtocol {
    typealias MentalRoutingDestination = MentalRoutingDestinationProtocol & MentalRoutingViewProviderProtocol
    
    func route(destination: MentalRoutingDestination, presentationStyle: MentalPresentationStyle) {
        let view = destination.destinationView
        let viewController = router.buildViewController(presentingView: .viewController(view))
        
        // Configure navigationItem here if it's needed
        
        router.navigate(viewController: viewController, presentationStyle: presentationStyle)
    }
}
