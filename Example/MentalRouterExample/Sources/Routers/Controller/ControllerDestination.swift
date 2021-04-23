//
//  ControllerDestination.swift
//  MentalRouterExample
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit
import MentalRouter

enum ControllerDestination: MentalRoutingDestinationProtocol {
    case simpleText
}

extension ControllerDestination: MentalRoutingControllerProviderProtocol {
    var viewController: UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.main)
        let viewController: SimpleViewController
        
        viewController = storyboard.instantiateViewController(identifier: "SimpleViewController")
        
        return viewController
    }
}
