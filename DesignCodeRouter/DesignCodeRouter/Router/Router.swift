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
    case present
    case replaceRoot
}

enum PresentingView {
    case viewController(_ rootView: AnyView)
    indirect case navigationController(_ view: PresentingView)
}

final class Router {
    private var window: UIWindow
    
    private var topViewController: UIViewController? {
        guard let rootViewController = window.rootViewController else {
            return nil
        }
        
        guard let navigationViewController = rootViewController as? UINavigationController else {
            return rootViewController
        }
        
        return navigationViewController.topViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: Public methods
extension Router {
    func initialSetup() {
        let contentView = ContentView(viewModel: ContentViewModel()).castToAnyView()
        let presentingView: PresentingView = .navigationController(.viewController(contentView))
        
        navigate(view: presentingView, presentationStyle: .replaceRoot)
    }
    
    func navigate(view: PresentingView, presentationStyle: PresentationStyle) {
        let viewController = buildViewController(presentingView: view)
        
        switch presentationStyle {
        case .present:
            topViewController?.navigationController?.present(viewController, animated: true, completion: nil)
            
        case .push:
            topViewController?.navigationController?.pushViewController(viewController, animated: true)
            
        case .replaceRoot:
            window.rootViewController = viewController
        }
    }
}

// MARK: Private methods
private extension Router {
    func buildViewController(presentingView: PresentingView) -> UIViewController {
        switch presentingView {
        case let .viewController(rootView):
            return UIHostingController(rootView: rootView)
            
        case let .navigationController(presentingView):
            let viewController = buildViewController(presentingView: presentingView)
            
            return UINavigationController(rootViewController: viewController)
        }
    }
}
