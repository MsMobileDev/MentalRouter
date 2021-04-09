//
//  DetailRouter.swift
//  DesignCodeRouter
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
    
    func route(destination: RoutingDestination) {
        let view = destination.destinationView
        
        router.navigate(view: .viewController(view),
                        presentationStyle: .present(presentationStyle: .overFullScreen, transitionStyle: .coverVertical))
    }
}
