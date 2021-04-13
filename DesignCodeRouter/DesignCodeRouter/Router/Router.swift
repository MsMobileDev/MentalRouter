//
//  UIKitRouter.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 07.04.2021.
//

import UIKit
import SwiftUI

enum PresentationStyle {
    case push
    case present(presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    case replaceRoot
}

enum PresentingView {
    case viewController(_ rootView: AnyView)
    indirect case navigationController(_ view: PresentingView)
}

final class Router {
    static let `default`: Router = Router()
    
    private var window: UIWindow!
    
    private var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    private init() {}
}

// MARK: Public methods
extension Router {
    func initialSetup(window: UIWindow) {
        self.window = window
        
        let contentView = ContentView(viewModel: ContentViewModel()).castToAnyView()
        let presentingView: PresentingView = .navigationController(.viewController(contentView))
        let viewController = buildViewController(presentingView: presentingView)
        
        navigate(viewController: viewController, presentationStyle: .replaceRoot)
    }
    
    func buildViewController(presentingView: PresentingView) -> UIViewController {
        switch presentingView {
        case let .viewController(rootView):
            return UIHostingController(rootView: rootView)
            
        case let .navigationController(presentingView):
            let viewController = buildViewController(presentingView: presentingView)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    func navigate(viewController: UIViewController, presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case let .present(modalPresentationStyle, modalTransitionStyle):
            DispatchQueue.main.async {
                viewController.modalPresentationStyle = modalPresentationStyle
                viewController.modalTransitionStyle = modalTransitionStyle
                
                self.navigationController?.present(viewController, animated: true, completion: nil)
            }
            
        case .push:
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        case .replaceRoot:
            DispatchQueue.main.async {
                self.window.rootViewController = viewController
            }
        }
    }
    
    func rollBack() {
        DispatchQueue.main.async {
            guard let visibleController = self.navigationController?.visibleViewController,
                  visibleController.canPerformRollBackAction() else { return }
            
            if visibleController.isPresented {
                visibleController.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
