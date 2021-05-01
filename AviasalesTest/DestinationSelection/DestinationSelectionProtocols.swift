//
//  DestinationSelectionProtocols.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

protocol DestinationSelectionViewInput: AnyObject {
    var customView: DestinationSelectionView { get }
    
    func showMessage(message: String)
    func updateDataSource(dataSource: [CityViewModel])
}

protocol DestinationSelectionViewOutput: AnyObject {
    func didChangeText(to text: String?)
    func didSelectCity(cityModel: CityViewModel)
}

protocol DestinationSelectionRouterInput: AnyObject {
    func routeToMapController(startModel: CityViewModel, destinationModel: CityViewModel)
}
