//
//  ControllerRouter.swift
//  MentalRouterExample
//
//  Created by Olga Shilenko on 20.04.2021.
//

import Foundation
import MentalRouter

final class ControllerRouter {
    private let router: MentalRouter
    
    init(router: MentalRouter) {
        self.router = router
    }
}

extension ControllerRouter: MentalRouterProtocol {
    typealias MentalRoutingDestination = MentalRoutingDestinationProtocol & MentalRoutingControllerProviderProtocol
    
    func route(destination: MentalRoutingDestination, presentationStyle: MentalPresentationStyle) {
        let viewController = destination.viewController
        let configuredViewController = router.buildViewController(presentingViewController: .viewController(viewController))
        
        // Configure navigationItem here if it needed
        
        router.navigate(viewController: configuredViewController, presentationStyle: presentationStyle)
    }
}
