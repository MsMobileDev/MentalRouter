//
//  MSRouterProtocol.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation

public protocol MSRouterProtocol {
    associatedtype MSRoutingDestination
    
    func route(destination: MSRoutingDestination, presentationStyle: MSPresentationStyle)
    func rollBack()
}

public extension MSRouterProtocol {
    func rollBack() {
        MSRouter.default.rollBack()
    }
}
