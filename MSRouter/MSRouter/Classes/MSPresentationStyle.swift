//
//  MSPresentationStyle.swift
//  MSRouter
//
//  Created by Olga Shilenko on 19.04.2021.
//

import UIKit

public enum MSPresentationStyle {
    case push
    case present(presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    case replaceRoot
    case custom(transition: MSNavigationTransition)
}
