//
//  DestinationSelectionAssembly.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class DestinationSelectionAssembly {

    func configureModule() -> UIViewController {
        let controller = DestinationSelectionController()
        let router = DestinationSelectionRouter(viewController: controller)
        let presenter = DestinationSelectionPresenter(client: NetworkServiceImpl())

        presenter.router = router
        presenter.view = controller
        controller.output = presenter

        return controller
    }
    
}
