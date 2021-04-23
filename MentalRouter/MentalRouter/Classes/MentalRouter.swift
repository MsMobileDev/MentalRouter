//
//  UIKitRouter.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 07.04.2021.
//

import UIKit
import SwiftUI

/// Class represents general router for whole application
public final class MentalRouter {
    /// Static instance of MentalRouter class
    public static let `default`: MentalRouter = MentalRouter()
    
    private var window: UIWindow!
    
    private var transitionHandler: MentalTransitionHandler?
    
    private var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    private init() {}
}

// MARK: Public methods
public extension MentalRouter {
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
    
    /// This method build UIViewController from MentalPresentingView
    ///
    /// - Parameters:
    ///     - presentingView: MentalPresentingView
    ///
    /// Call this method to configure UIViewController before navigate to it
    ///
    func buildViewController(presentingView: MentalPresentingView) -> UIViewController {
        switch presentingView {
        case let .viewController(rootView):
            return UIHostingController(rootView: rootView)
            
        case let .navigationController(presentingView):
            let viewController = buildViewController(presentingView: presentingView)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    /// This method build UIViewController from MentalPresentingViewController
    ///
    /// - Parameters:
    ///     - presentingViewController: MentalPresentingViewController
    ///
    /// Call this method to configure UIViewController before navigate to it
    ///
    func buildViewController(presentingViewController: MentalPresentingViewController) -> UIViewController {
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
    ///     - presentationStyle: MentalPresentationStyle
    ///
    /// Code of this method executes in main thread, so there is no need to wrap this method in main thread.
    ///
    func navigate(viewController: UIViewController, presentationStyle: MentalPresentationStyle) {
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
                self.transitionHandler = MentalTransitionHandler(navigationTransition: transition)
                
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
                fatalError("MentalRouter can't roll back the first item in navigation stack.")
            }
            
            if visibleController.isPresented {
                visibleController.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
