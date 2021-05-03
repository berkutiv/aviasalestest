//
//  BaseRouter.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

class BaseRouter {

    weak var viewController: UIViewController?

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
}
