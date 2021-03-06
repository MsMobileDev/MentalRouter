//
//  DetailViewModel.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 09.04.2021.
//

import UIKit
import MentalRouter

final class DetailViewModel {
    enum State {
        case initial
        case rollBack
    }
    
    var state: State {
        didSet {
            setup(state: state)
        }
    }
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
        self.state = .initial
        
        self.setup(state: state)
    }
}

// MARK: Private methods
private extension DetailViewModel {
    func setup(state: State) {
        switch state {
        case .initial:
            break
            
        case .rollBack:
            MentalRouter.detailRouter.rollBack()
        }
    }
}
