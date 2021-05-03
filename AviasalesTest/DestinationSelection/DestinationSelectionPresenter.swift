//
//  DestinationSelectionPresenter.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation
import MapKit

final class DestinationSelectionPresenter {

    // MARK: - Public Properties

    weak var view: DestinationSelectionViewInput!
    var router: DestinationSelectionRouterInput!
    var client: NetworkService

    // MARK: - Private Properties

    private var urlRequest: URLSessionDataTask?
    private let spCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(59.56), longitude: CLLocationDegrees(30.18))

    init(client: NetworkService) {
        self.client = client
    }
    
}

// MARK: - DestinationSelectionViewOutput

extension DestinationSelectionPresenter: DestinationSelectionViewOutput {

    func didChangeText(to text: String?) {
        urlRequest?.cancel()
        urlRequest = client.places(text: text ?? "") { [weak self] result in
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
        let spCityViewModel = CityViewModel(name: "Saint-Petersburg", iata: "LED", airportName: "Pulkovo", coordinates: spCoordinates)
        router.routeToMapController(startModel: spCityViewModel, destinationModel: cityModel)
    }

}
