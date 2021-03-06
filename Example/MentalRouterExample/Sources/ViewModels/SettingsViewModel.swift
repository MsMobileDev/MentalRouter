//
//  SettingsViewModel.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 12.04.2021.
//

import SwiftUI
import MentalRouter

struct SettingsViewModel {
    var presentationMode: PresentationMode = .push
    var modalPresentationStyle: ModalPresentationStyle = .pageSheet
    var modalTransitionStyle: ModalTransitionStyle = .coverVertical
    
    var presentationStyle: MentalPresentationStyle {
        switch presentationMode {
        case .push:
            return .push
            
        case .present:
            return .present(presentationStyle: modalPresentationStyle.uiModalPresentationStyle,
                            transitionStyle: modalTransitionStyle)
            
        case .custom:
            return .custom(transition: MentalNavigationTransition(presented: nil, dismissed: nil))
        }
    }
}

extension SettingsViewModel {
    typealias ModalTransitionStyle = UIModalTransitionStyle
    
    enum PresentationMode: Int, CaseIterable, Identifiable {
        case push
        case present
        case custom
        
        public var id: Int { return rawValue }
        
        var description: String {
            switch self {
            case .push:
                return "push"
                
            case .present:
                return "present"
                
            case .custom:
                return "custom"
            }
        }
    }
    
    enum ModalPresentationStyle: Int, CaseIterable, Identifiable {
        case pageSheet
        case overFullScreen
        
        public var id: Int { return rawValue }
        
        var description: String {
            switch self {
            case .pageSheet:
                return "pageSheet"
                
            case .overFullScreen:
                return "overFullScreen"
            }
        }
        
        var uiModalPresentationStyle: UIModalPresentationStyle {
            switch self {
            case .overFullScreen:
                return .overFullScreen
                
            case .pageSheet:
                return .pageSheet
            }
        }
    }
}

extension UIModalTransitionStyle: CaseIterable, Identifiable {
    public var id: Int { return rawValue }
    
    public typealias AllCases = [UIModalTransitionStyle]
    
    public static var allCases: [UIModalTransitionStyle] {
        return [.coverVertical, .crossDissolve, .flipHorizontal]
    }
    
    var description: String {
        switch self {
        case .coverVertical:
            return "cover"
            
        case .crossDissolve:
            return "cross"
            
        case .flipHorizontal:
            return "flip"
            
        case .partialCurl:
            return "curl"
            
        @unknown default:
            fatalError()
        }
    }
}
