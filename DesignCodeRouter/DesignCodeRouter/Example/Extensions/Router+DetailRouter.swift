//
//  Router+DetailRouter.swift
//  DesignCodeRouter
//
//  Created by Olga Shilenko on 09.04.2021.
//

import Foundation

extension Router {
    static let detailRouter: DetailRouter = {
        return DetailRouter(router: Router.default)
    }()
}
