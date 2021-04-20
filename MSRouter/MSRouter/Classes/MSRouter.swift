//
//  UIKitRouter.swift
//  MSRouter
//
//  Created by Olga Shilenko on 07.04.2021.
//

import UIKit
import SwiftUI

public final class MSRouter {
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
    func initialSetup(window: UIWindow) {
        self.window = window
    }
    
    func buildViewController(presentingView: MSPresentingView) -> UIViewController {
        switch presentingView {
        case let .viewController(rootView):
            return UIHostingController(rootView: rootView)
            
        case let .navigationController(presentingView):
            let viewController = buildViewController(presentingView: presentingView)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    func buildViewController(presentingViewController: MSPresentingViewController) -> UIViewController {
        switch presentingViewController {
        case let .viewController(controller):
            return controller
            
        case let .navigationController(controller):
            let viewController = buildViewController(presentingViewController: controller)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
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
