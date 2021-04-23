//
//  ContentViewModel.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import Foundation
import SwiftUI
import MentalRouter

struct ContentViewModel {
    enum State {
        case initial
        case navigate(destination: MentalRoutingDestinationProtocol, transition: MentalNavigationTransition?)
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
            let presentationStyle: MentalPresentationStyle
            
            switch settingsViewModel.presentationMode {
            case .custom:
                guard let navigationTransition = transition else { fatalError() }
                
                presentationStyle = .custom(transition: navigationTransition)
                
            case .present, .push:
                presentationStyle = settingsViewModel.presentationStyle
            }
            
            if let destination = destination as? DetailDestination {
                MentalRouter.detailRouter.route(destination: destination, presentationStyle: presentationStyle)
            } else if let destination = destination as? ControllerDestination {
                MentalRouter.controllerRouter.route(destination: destination, presentationStyle: presentationStyle)
            }
        }
    }
}
