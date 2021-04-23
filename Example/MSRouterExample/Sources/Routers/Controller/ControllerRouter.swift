//
//  ControllerRouter.swift
//  MSRouterExample
//
//  Created by Olga Shilenko on 20.04.2021.
//

import Foundation
import MSRouter

final class ControllerRouter {
    private let router: MSRouter
    
    init(router: MSRouter) {
        self.router = router
    }
}

extension ControllerRouter: MSRouterProtocol {
    typealias MSRoutingDestination = MSRoutingDestinationProtocol & MSRoutingControllerProviderProtocol
    
    func route(destination: MSRoutingDestination, presentationStyle: MSPresentationStyle) {
        let viewController = destination.viewController
        let configuredViewController = router.buildViewController(presentingViewController: .viewController(viewController))
        
        // Configure navigationItem here if it needed
        
        router.navigate(viewController: configuredViewController, presentationStyle: presentationStyle)
    }
}
