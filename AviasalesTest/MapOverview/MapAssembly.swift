//
//  MapAssembly.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class MapAssembly {

    func configureModule(startCity: CityViewModel, destinationCity: CityViewModel) -> UIViewController {
        let controller = MapViewController()
        let router = MapRouter(viewController: controller)
        let presenter = MapPresenter(startCity: startCity, destinationCity: destinationCity)

        presenter.router = router
        presenter.view = controller
        controller.output = presenter

        return controller
    }
}
