//
//  RouterProtocol.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

protocol RouterProtocol {
    associatedtype RoutingDestination
    
    func route(destination: RoutingDestination)
    func rollBack()
}

extension RouterProtocol {
    func rollBack() {
        Router.default.rollBack()
    }
}
