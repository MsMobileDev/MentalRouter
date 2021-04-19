//
//  ContentViewModel.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation
import SwiftUI

struct ContentViewModel {
    enum State {
        case initial
        case navigate(destination: RoutingDestinationProtocol, transition: NavigationTransition?)
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
                    Router.detailRouter.route(destination: destination,
                                              presentationStyle: .custom(transition: navigationTransition))
                } else {
                    Router.detailRouter.route(destination: destination, presentationStyle: settingsViewModel.presentationStyle)
                }
            }
        }
    }
}
