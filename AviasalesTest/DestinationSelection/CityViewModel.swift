//
//  CityViewModel.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit
import MapKit

struct CityViewModel {
    var name: String
    var iata: String?
    var airportName: String?
    var coordinates: CLLocationCoordinate2D

    init(with cityModel: CityModel) {
        name = cityModel.name
        iata = cityModel.iata
        airportName = cityModel.airportName
        coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(cityModel.location.lat), longitude: CLLocationDegrees(cityModel.location.lon))
    }

    init(name: String, iata: String?, airportName: String?, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.iata = iata
        self.airportName = airportName
        self.coordinates = coordinates
    }
}
