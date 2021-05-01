//
//  DestinationSelectionPresenter.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation
import MapKit

final class DestinationSelectionPresenter {

    weak var view: DestinationSelectionViewInput!
    var router: DestinationSelectionRouterInput!
    private var urlRequest: URLSessionDataTask?
}

extension DestinationSelectionPresenter: DestinationSelectionViewOutput {

    func didChangeText(to text: String?) {
        urlRequest?.cancel()
        urlRequest = NetworkService.places(text: text ?? "") { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let cityModels):
                    let viewModels = cityModels.map({ CityViewModel(with: $0) })
                    self.view.updateDataSource(dataSource: viewModels)
                case .failure(let errorModel):
                    self.view.showMessage(message: errorModel.message)
                }
            }
        }
    }

    func didSelectCity(cityModel: CityViewModel) {
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(59.56), longitude: CLLocationDegrees(30.18))
        let startCity = CityViewModel(name: "Saint-Petersburg", iata: "LED", airportName: "Pulkovo", coordinates: coordinates)
        router.routeToMapController(startModel: startCity, destinationModel: cityModel)
    }
}
