//
//  UIKitRouter.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 07.04.2021.
//

import UIKit
import SwiftUI

final class Router {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: Public methods
extension Router {
    func initialSetup() {
        let contentView = ContentView(viewModel: ContentViewModel())
        let viewController = UIHostingController(rootView: contentView)
        
        window.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    func navigate(view: AnyView) {
        let viewController = UIHostingController(rootView: view)
        (window.rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
}
