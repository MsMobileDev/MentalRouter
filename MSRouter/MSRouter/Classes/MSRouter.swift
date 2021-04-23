//
//  UIKitRouter.swift
//  MSRouter
//
//  Created by Olga Shilenko on 07.04.2021.
//

import UIKit
import SwiftUI

/// Class represents general router for whole application
public final class MSRouter {
    /// Static instance of MSRouter class
    public static let `default`: MSRouter = MSRouter()
    
    private var window: UIWindow!
    
    private var transitionHandler: MSTransitionHandler?
    
    private var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    private init() {}
}

// MARK: Public methods
public extension MSRouter {
    /// This method initialises general application router with window
    ///
    /// - Parameters:
    ///     - window: UIWindow
    ///
    /// This method should be called before setting window as key and visible
    ///
    func initialSetup(window: UIWindow) {
        self.window = window
    }
    
    /// This method build UIViewController from MSPresentingView
    ///
    /// - Parameters:
    ///     - presentingView: MSPresentingView
    ///
    /// Call this method to configure UIViewController before navigate to it
    ///
    func buildViewController(presentingView: MSPresentingView) -> UIViewController {
        switch presentingView {
        case let .viewController(rootView):
            return UIHostingController(rootView: rootView)
            
        case let .navigationController(presentingView):
            let viewController = buildViewController(presentingView: presentingView)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    /// This method build UIViewController from MSPresentingViewController
    ///
    /// - Parameters:
    ///     - presentingViewController: MSPresentingViewController
    ///
    /// Call this method to configure UIViewController before navigate to it
    ///
    func buildViewController(presentingViewController: MSPresentingViewController) -> UIViewController {
        switch presentingViewController {
        case let .viewController(controller):
            return controller
            
        case let .navigationController(controller):
            let viewController = buildViewController(presentingViewController: controller)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    /// This method navigate to current view controller with specified presentation style
    ///
    ///  - Parameters:
    ///     - viewController: UIViewController
    ///     - presentationStyle: MSPresentationStyle
    ///
    /// Code of this method executes in main thread, so there is no need to wrap this method in main thread.
    ///
    func navigate(viewController: UIViewController, presentationStyle: MSPresentationStyle) {
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
            
        case let .custom(transition):
            DispatchQueue.main.async {
                self.transitionHandler = MSTransitionHandler(navigationTransition: transition)
                
                viewController.transitioningDelegate = self.transitionHandler
                viewController.modalPresentationStyle = .custom
                
                self.navigationController?.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    /// This method rolls back top screen in the navigation stack.
    /// If try to roll back the first screen from the navigation stack, the fatal error will happen.
    ///
    func rollBack() {
        DispatchQueue.main.async {
            guard let visibleController = self.navigationController?.visibleViewController,
                  visibleController.canPerformRollBackAction() else {
                fatalError("MSRouter can't roll back the first item in navigation stack.")
            }
            
            if visibleController.isPresented {
                visibleController.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
