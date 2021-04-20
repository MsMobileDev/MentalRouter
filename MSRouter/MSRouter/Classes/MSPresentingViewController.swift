//
//  MSPresentingViewController.swift
//  MSRouter
//
//  Created by Olga Shilenko on 20.04.2021.
//

import UIKit

public enum MSPresentingViewController {
    case viewController(_ controller: UIViewController)
    indirect case navigationController(_ controller: MSPresentingViewController)
}
