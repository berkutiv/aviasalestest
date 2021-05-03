//
//  MapAssembly.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class MapAssembly {

    func configureModule(mapInputModel: MapInputModel) -> UIViewController {
        let controller = MapViewController()
        let router = MapRouter(viewController: controller)
        let presenter = MapPresenter(mapInputModel: mapInputModel)

        presenter.router = router
        presenter.view = controller
        controller.output = presenter

        return controller
    }
    
}
