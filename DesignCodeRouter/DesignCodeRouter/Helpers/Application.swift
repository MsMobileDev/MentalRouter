//
//  Application.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 08.04.2021.
//

import UIKit

final class Application {
    static let shared: Application = Application()
    
    var keyWindow: UIWindow!
    
    lazy var router: Router = {
        guard let keyWindow = self.keyWindow else {
            fatalError("Bad try to create Router without a keyWindow")
        }
        
        return Router(window: keyWindow)
    }()
}
