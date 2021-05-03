//
//  GetPlacesResponse.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

struct CityModel: Decodable {
    let name: String
    let iata: String?
    let airportName: String?
    let location: Coordinates
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
}
