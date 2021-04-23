//
//  ControllerDestination.swift
//  MSRouterExample
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit
import MSRouter

enum ControllerDestination: MSRoutingDestinationProtocol {
    case simpleText
}

extension ControllerDestination: MSRoutingControllerProviderProtocol {
    var viewController: UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
        let viewController: SimpleViewController
        
        viewController = storyboard.instantiateViewController(identifier: "SimpleViewController")
        
        return viewController
    }
}
