//
//  ContentViewModel.swift
//  MSRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation
import SwiftUI
import MSRouter

struct ContentViewModel {
    enum State {
        case initial
        case navigate(destination: MSRoutingDestinationProtocol, transition: MSNavigationTransition?)
    }
    
    var colors: [UIColor]
    
    var settingsViewModel: SettingsViewModel
    
    var state: State! {
        didSet {
            setup(state: state)
        }
    }
    
    init() {
        self.colors = [.blue, .red, .yellow]
        self.settingsViewModel = SettingsViewModel()
        self.state = .initial
        
        self.setup(state: state)
    }
}

private extension ContentViewModel {
    func setup(state: State) {
        switch state {
        case .initial:
            break
            
        case let .navigate(destination, transition):
            if let destination = destination as? DetailDestination {
                if let navigationTransition = transition {
                    MSRouter.detailRouter.route(destination: destination,
                                              presentationStyle: .custom(transition: navigationTransition))
                } else {
                    MSRouter.detailRouter.route(destination: destination, presentationStyle: settingsViewModel.presentationStyle)
                }
            } else if let destination = destination as? ControllerDestination {
                MSRouter.controllerRouter.route(destination: destination, presentationStyle: settingsViewModel.presentationStyle)
            }
        }
    }
}
