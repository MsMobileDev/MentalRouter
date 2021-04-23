//
//  Router+CustomRouters.swift
//  MSRouter
//
//  Created by Olga Shilenko on 09.04.2021.
//

import MSRouter

extension MSRouter {
    static let detailRouter: DetailRouter = {
        return DetailRouter(router: MSRouter.default)
    }()
    
    static let controllerRouter: ControllerRouter = {
        return ControllerRouter(router: MSRouter.default)
    }()
}
