//
//  Router+CustomRouters.swift
//  MentalRouter
//
//  Created by Olga Shilenko on 09.04.2021.
//

import MentalRouter

extension MentalRouter {
    static let detailRouter: DetailRouter = {
        return DetailRouter(router: MentalRouter.default)
    }()
    
    static let controllerRouter: ControllerRouter = {
        return ControllerRouter(router: MentalRouter.default)
    }()
}
