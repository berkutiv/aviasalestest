//
//  DestinationSelectionRouter.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

final class DestinationSelectionRouter: BaseRouter, DestinationSelectionRouterInput {
    
    func routeToMapController(startModel: CityViewModel, destinationModel: CityViewModel) {
        let controller = MapAssembly().configureModule(startCity: startModel, destinationCity: destinationModel)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
